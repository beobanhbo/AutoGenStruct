import 'dart:io';

import 'package:args/args.dart';
import 'package:auto_gen_struct/command/command_method.dart';
import 'package:auto_gen_struct/command/create/create_structure_command.dart';
import 'package:auto_gen_struct/command/help/help_command.dart';
import 'package:auto_gen_struct/constant/app_constant.dart';
import 'package:auto_gen_struct/text/text_log.dart';

class AutoGenStruct {
  late ArgParser _argParser;

  AutoGenStruct._(this._argParser);

  factory AutoGenStruct() {
    final argParser = ArgParser();

    return AutoGenStruct._(argParser);
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
      stdout.writeln('Command not found!');

      _exit();
    }
  }

  void _listenArgument(String argument) async {
    CommandMethod? commandMethod;
    dynamic result;
    switch (argument) {
      case AppConstant.create:
        commandMethod = CreateStructureCommand();
        result = await commandMethod.selectOption();
        break;
      case AppConstant.help:
        commandMethod = HelpCommand();
        break;

      default:
        _exit();
    }
    commandMethod!.execute(result);
  }

  bool confirmAction() {
    stdout.writeln('🪛${TextLog.log(
      colorName: ColorName.green,
      text: 'Do you want to continue? [y/n] ',
    )}');

    ///Capture a String from the console
    final result = stdin.readLineSync();
    bool continues = result?.toLowerCase().trim() == 'y' ||
        result?.toLowerCase().trim() == 'yes';
    return continues;
  }

  void _exit() {
    stderr.writeln('Command not found!');
    stderr.writeln('Run with -h option to get help');
    exit(1);
  }
}
