import 'dart:io';

import 'package:args/args.dart';
import 'package:auto_gen_struct/constant/app_constant.dart';

class AutoGenStruct {
  late ArgParser _argParser;
  late StringBuffer _stringBuffer;
  AutoGenStruct._(this._argParser, this._stringBuffer);

  factory AutoGenStruct() {
    final stringBuffer = StringBuffer();
    final argParser = ArgParser();

    return AutoGenStruct._(argParser, stringBuffer);
  }

  void run(List<String> arguments) {
    _addCommand();
    _handleArgument(arguments);
  }

  void _addCommand() {
    _argParser.addCommand(AppConstant.create);
    _argParser.addCommand(AppConstant.help);
  }

  void _handleArgument(List<String> arguments) {
    final arg = _argParser.parse(arguments);
    if (arg.command != null && arg.command?.name != null) {
      _listenArgument(arg.command!.name!);
    } else {
      _exit();
    }
  }

  void _listenArgument(String argument) {
    switch (argument) {
      case AppConstant.create:
        final result = confirmAction();
        if (result) {
        } else {
          exit(0);
        }
        break;
      case AppConstant.help:
        print('ss');
        break;

      default:
        _exit();
    }
  }

  bool confirmAction() {
    String content = '''
    Select option to generate Project structure:
    
    1. Default structure
    
    2. Import structure from json string
    
    3. Import structure from json file
    
    Do you want to continue? [y/n]''';
    _stringBuffer.write(content);

    ///Capture a String from the console
    final result = stdin.readLineSync();
    bool continues = result?.toLowerCase().trim() == 'y' ||
        result?.toLowerCase().trim() == 'yes';
    return continues;
  }

  void _exit() {
    _stringBuffer.writeln('Command not found!');
    _stringBuffer.writeln('Run with -h option to get help');
    exit(1);
  }
}
