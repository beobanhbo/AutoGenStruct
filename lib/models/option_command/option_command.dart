import 'package:auto_gen_struct/common/enums/option_type.dart';

class OptionCommand {
  String? title, id;
  OptionType optionType;
  OptionCommand({this.title, this.id = '', this.optionType = OptionType.none});
}
