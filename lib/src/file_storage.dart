import 'dart:convert';
import 'dart:io';

class FilesStorage {
  late String _baseDir;

  FilesStorage(String baseDir) {
    _baseDir = baseDir;
    _init();
  }

  Future<void> _init() async {
    await Directory(_baseDir).create(recursive: true);
  }

  Future<void> writeToFile(String filePath, Map<String, dynamic> data) async {
    await _ensureDirectoryExists(filePath);

    final file = File(filePath);
    final jsonString = jsonEncode(data);
    await file.writeAsString(jsonString);
  }

  Future<Map<String, dynamic>> readFromFile(String filePath) async {
    try {
      final file = File(filePath);

      if (!await file.exists()) {
        return {};
      }

      final content = await file.readAsString();

      if (content.isEmpty) {
        return {};
      }

      return jsonDecode(content) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  Future<void> _ensureDirectoryExists(String filePath) async {
    final directory = Directory(File(filePath).parent.path);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }
}
