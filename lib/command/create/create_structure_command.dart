import 'dart:io';

import 'package:auto_gen_struct/command/command_method.dart';
import 'package:auto_gen_struct/command/create/create_default_structure.dart';
import 'package:auto_gen_struct/command/repo/create_structure_repo.dart';
import 'package:auto_gen_struct/common/enums/option_type.dart';
import 'package:auto_gen_struct/models/option_command/option_command.dart';

class CreateStructureCommand extends CommandMethod {
  late CreateStructureRepo _repo;

  CreateStructureCommand() {
    _repo = CreateStructureRepo();
  }

  @override
  Future<dynamic> selectOption() async {
    List<OptionCommand> list = await _repo.getListOptions();
    for (var item in list) {
      stdout.writeln(item.title);
    }

    ///Capture a String from the console
    final result = stdin.readLineSync();
    String temp = (result ?? '').toLowerCase().trim();

    final option = list.firstWhere((element) => element.id == temp);
    return option;
  }

  @override
  Future execute(values) async {
    OptionCommand optionCommand = values;
    CommandMethod? commandMethod;
    dynamic result;

    switch (optionCommand.optionType) {
      case OptionType.createDefaultStruct:
        commandMethod = CreateDefaultStructure();
        result = await commandMethod.selectOption();
        break;
      case OptionType.createStructFromJsonString:
        // result = await CreateDefaultStructure().selectOption();

        break;
      case OptionType.createStructFromJsonFile:
        // result = await CreateDefaultStructure().selectOption();

        break;
      default:
        break;
    }
    commandMethod!.execute(result);

    return 0;
  }
}
