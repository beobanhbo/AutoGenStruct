import 'dart:io';

import 'package:http/http.dart' as http;

class DownloadFile {
  Future<void> createFileFromUrl(
      {required String url,
      required String filename,
      required String path}) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));
      File file = File('$path/$filename');
      await file.writeAsBytes(response.bodyBytes);
    } catch (e) {
      stderr.writeln("Create file $filename error!. Ignoring this file!");
    }
  }
}
