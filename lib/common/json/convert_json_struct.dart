import 'dart:convert';
import 'dart:io';

import 'package:auto_gen_struct/models/structure/structure.dart';

class ConvertJsonStruct {
  static String getProjectStructToJson(String rootProject) {
    final listDir = getListDir(rootProject + 'lib', rootProject);

    Map<String, dynamic> map = {};

    for (var item in listDir) {
      map.putIfAbsent(item.name, () => item.toJson());
    }
    return jsonEncode(map);
  }

  static List<Structure> getListDir(String path, String rootPath) {
    Directory current = Directory(path);

    List<FileSystemEntity> entities = current.listSync();
    List<Structure> children = [];

    for (FileSystemEntity entity in entities) {
      String type = FileSystemEntity.typeSync(entity.path) ==
              FileSystemEntityType.directory
          ? 'directory'
          : 'file';

      if (type == 'directory') {
        final child = getListDir(entity.path, rootPath);
        children.add(FolderStruct(
          name: entity.path.split('/').last,
          path: entity.path.replaceFirst(rootPath, ''),
          children: child,
        ));
      } else {
        children.add(FileStruct(
          name: entity.path.split('/').last,
          path: entity.path.replaceFirst(rootPath, ''),
        ));
      }
    }
    return children;
  }
}
