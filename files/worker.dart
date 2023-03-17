import 'dart:async';
import 'dart:isolate';

enum IsolateProcess { jsonDecoding, timeLock, refreshAccountResource }

class IsolateDataWrapper {
  final IsolateProcess isolateProcess;
  final dynamic message;
  final int identifier;

  IsolateDataWrapper(this.isolateProcess, this.message, this.identifier);
}

class CompleterWrapper<T> {
  late Completer<T> completer;
  late int identifier;

  CompleterWrapper() {
    completer = Completer<T>();
    identifier = DateTime.now().microsecondsSinceEpoch;
  }
}

class Worker {
  late Isolate anotherIsolate;
  late SendPort anotherSendPort;
  StreamController mainListener = StreamController.broadcast();
  Completer<void> isolateState = Completer();
  Map<String, CompleterWrapper<dynamic>> pool = {};

  Worker() {
    _init();
  }

  Future<void> dispose() async {
    await mainListener.close();
    anotherIsolate.kill(priority: 0);
  }

  Future<void> init() async {
    return await isolateState.future;
  }

  void anotherIsolateEntry(SendPort sendPort) {
    ReceivePort receiverPort = ReceivePort();
    sendPort.send(receiverPort.sendPort);
    receiverPort.listen((dynamic data) async {
      if (data is IsolateDataWrapper) {
        data.message["sendPort"] = sendPort;
        data.message["identifier"] = data.identifier;
        if (data.isolateProcess == IsolateProcess.timeLock) {
          _countingTimeLock(data.message);
        } else if (data.isolateProcess ==
            IsolateProcess.refreshAccountResource) {
          _refreshAccountData(data.message);
        }
      }
    }, onError: (error) {});
  }

  void _init() async {
    final mainReceivePort = ReceivePort();
    if (mainListener.isClosed) mainListener = StreamController.broadcast();
    anotherIsolate = await Isolate.spawn(
        anotherIsolateEntry, mainReceivePort.sendPort,
        onError: mainReceivePort.sendPort, onExit: mainReceivePort.sendPort);
    mainReceivePort.listen((onData) {
      mainListener.add(onData);
    }, onError: (error) {});

    mainListener.stream.listen((data) async {
      if (data is SendPort) {
        anotherSendPort = data;
        isolateState.complete();
      } else if (data is IsolateDataWrapper) {
        complete(data);
      } else if (data == null) {
        await dispose();
        isolateState = Completer();
        _init();
      }
    });
  }

  void complete(IsolateDataWrapper data) {
    final com = pool.remove(data.identifier.toString());
    if (com != null) {
      com.completer.complete(data.message);
      pool.remove(com);
    }
  }

  Future refreshAccountResource() async {
    final newCompleter = CompleterWrapper();
    pool[newCompleter.identifier.toString()] = newCompleter;
    newCompleter.completer = Completer();
    Map<String, dynamic> props = {
      "refresh": true,
    };
    anotherSendPort.send(IsolateDataWrapper(
        IsolateProcess.refreshAccountResource, props, newCompleter.identifier));
    return newCompleter.completer.future;
  }

  Future _refreshAccountData(Map<String, dynamic> props) async {
    SendPort sendPort = props["sendPort"];
    final int identifier = props["identifier"];
    try {
      sendPort.send(IsolateDataWrapper(
          IsolateProcess.refreshAccountResource, props, identifier));
    } catch (e) {
      sendPort.send(IsolateDataWrapper(
          IsolateProcess.refreshAccountResource, null, identifier));
    }
  }

  Future startTimeLock(Duration duration) async {
    final newCompleter = CompleterWrapper();
    newCompleter.completer = Completer();

    pool[newCompleter.identifier.toString()] = newCompleter;

    await Future.delayed(duration, () {
      Map<String, dynamic> props = {
        "shouldLock": true,
      };
      anotherSendPort.send(IsolateDataWrapper(
          IsolateProcess.timeLock, props, newCompleter.identifier));
    });

    return newCompleter.completer.future;
  }

  Future _countingTimeLock(Map<String, dynamic> props) async {
    SendPort sendPort = props["sendPort"];
    final int identifier = props["identifier"];
    try {
      sendPort
          .send(IsolateDataWrapper(IsolateProcess.timeLock, props, identifier));
    } catch (e) {
      sendPort
          .send(IsolateDataWrapper(IsolateProcess.timeLock, null, identifier));
    }
  }
}
