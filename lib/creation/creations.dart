import 'dart:io';

abstract class CreateMethod {
  Future<void> create(String path);
}

abstract class DirectoryCreationMethod {
  Future<bool> createDirectory(Map<String, dynamic> json);
  Future<dynamic> getStructureFromPath(String path);
}

abstract class FileCreateMethod {
  Future<void> createFile();
}
