import 'dart:io';

import 'package:auto_gen_struct/common/json/read_json.dart';
import 'package:auto_gen_struct/constant/app_constant.dart';
import 'package:auto_gen_struct/creation/creations.dart';
import 'package:auto_gen_struct/models/structure/structure.dart';

class DirectoryCreation implements DirectoryCreationMethod {
  late final String basePath;
  @override
  Future<bool> createDirectory(Map<String, dynamic> json) async {
    try {
      final libDir = Directory(AppConstant.lib);
      if (libDir.existsSync()) {
        basePath = libDir.absolute.path;
      } else {
        final createDir =
            await Directory(AppConstant.lib).create(recursive: true);
        basePath = createDir.absolute.path;
      }

      List<Structure> listStruct = Structure.mapToStructure(json);
      for (var item in listStruct) {
        if (item.type == 'directory') {
          item.create(item.getAbsolutePath(basePath, item.path));
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future getStructureFromPath(String path) async {
    final result = await ReadJson.readJsonFromString(path);
    return result;
  }
}
