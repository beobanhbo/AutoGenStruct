import 'dart:io';

import 'package:auto_gen_struct/constant/app_constant.dart';
import 'package:auto_gen_struct/creation/creations.dart';

class DirectoryCreation implements DirectoryCreationMethod {
  late final String basePath;

  @override
  // TODO: implement getDirectory
  Directory get getDirectory => throw UnimplementedError();

  @override
  Future<bool> createDirectory({String? json}) async {
    try {
      final libDir = Directory(AppConstant.lib);
      if (libDir.existsSync()) {
        basePath = libDir.absolute.path;
      } else {
        final createDir =
            await Directory(AppConstant.lib).create(recursive: true);
        basePath = createDir.absolute.path;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
