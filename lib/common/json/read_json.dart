import 'dart:convert';
import 'dart:io';

class ReadJson {
  static Future<Map<String, dynamic>> readJsonFromPath(String path) async {
    var aa = await File('packages/AutoGenStruct/json/default_struct.json')
        .existsSync();
    print(aa);

    var input = await File('packages/AutoGenStruct/json/default_struct.json')
        .readAsString();
    final data = jsonDecode(input);
    return data;
  }

  static Future<Map<String, dynamic>> readJsonFromString(String json) async {
    final data = jsonDecode(json);
    return data;
  }
}
