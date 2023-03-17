import 'package:auto_gen_struct/common/enums/option_type.dart';
import 'package:auto_gen_struct/models/option_command/option_command.dart';
import 'package:auto_gen_struct/text/text_log.dart';

class CreateStructureRepo {
  Future<List<OptionCommand>> getListOptions() async {
    List<OptionCommand> list = [];
    list.add(OptionCommand(
        title: '🪛${TextLog.log(
      colorName: ColorName.green,
      text: 'Select option to generate Project structure:',
    )}'));
    list.add(OptionCommand(
        title: TextLog.log(
          colorName: ColorName.blue,
          text: '1. Default structure',
        ),
        id: '1',
        optionType: OptionType.createDefaultStruct));
    list.add(OptionCommand(
        title: TextLog.log(
          colorName: ColorName.blue,
          text: '2. Import structure from json string',
        ),
        id: '2',
        optionType: OptionType.createStructFromJsonString));
    list.add(OptionCommand(
        title: TextLog.log(
          colorName: ColorName.blue,
          text: '3. Import structure from json file',
        ),
        id: '3',
        optionType: OptionType.createStructFromJsonFile));
    list.add(OptionCommand(
        title: TextLog.log(
      colorName: ColorName.green,
      text: 'Select 1 option to continue:',
    )));
    return list;
  }
}
