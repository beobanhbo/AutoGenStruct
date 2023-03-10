import 'dart:io';

abstract class CreateMethod {
  Future<void> create();
}

abstract class DirectoryCreationMethod {
  Future<bool> createDirectory({String? json});
  Directory get getDirectory;
}

abstract class FileCreateMethod {
  Future<void> createFile();
}
