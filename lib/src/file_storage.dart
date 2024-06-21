import 'dart:convert';
import 'dart:io';

class FilesStorage {
  FilesStorage(String baseDir) {
    _baseDir = baseDir;
    _init();
  }

  late String _baseDir;

  Future<void> _init() async {
    await Directory(_baseDir).create(recursive: true);
  }

  Future<void> writeToFile(String filePath, Map<String, dynamic> data) async {
    _ensureDirectoryExists(filePath);

    final file = File(filePath);
    final jsonString = jsonEncode(data);
    await file.writeAsString(jsonString);
  }

  Future<Map<String, dynamic>> readFromFile(String filePath) async {
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
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

  void _ensureDirectoryExists(String filePath) {
    final directory = Directory(File(filePath).parent.path);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
  }
}
