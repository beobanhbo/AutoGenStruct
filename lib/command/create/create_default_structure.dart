import 'dart:io';

import 'package:auto_gen_struct/command/command_method.dart';
import 'package:auto_gen_struct/constant/app_constant.dart';
import 'package:auto_gen_struct/creation/directory/directory_creation.dart';
import 'package:auto_gen_struct/utils/app_assets.dart';

class CreateDefaultStructure extends CommandMethod {
  late DirectoryCreation _directoryCreation;

  CreateDefaultStructure() {
    _directoryCreation = DirectoryCreation();
  }

  @override
  Future execute(values) async {
    // final json = await _directoryCreation.getStructureFromPath(values);

    await _directoryCreation.createDirectory(AppConstant.defaultStructure);
  }

  @override
  Future selectOption() async {
    stdout.write('Importing default structure...');
    var fullFilePath = AppAssets.defaultStructJson;
    return fullFilePath;
  }
}
