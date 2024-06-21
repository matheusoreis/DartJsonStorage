import 'package:json_storage/src/file_storage.dart';
import 'package:path/path.dart' as path;

class JsonORM<T> {
  JsonORM(String baseDir, String category) {
    _baseDir = baseDir;
    _category = category;
    _fileStorage = FilesStorage(baseDir);
  }

  late String _baseDir;
  late FilesStorage _fileStorage;
  late String _category;

  Future<List<T>> query(bool Function(Map<String, dynamic>) filter, T Function(Map<String, dynamic>) fromJson) async {
    final results = <T>[];

    final filePath = _getFilePath();
    final data = await _fileStorage.readFromFile(filePath);

    if (data.containsKey(_category)) {
      final jsonData = data[_category] as List<dynamic>;

      for (final entry in jsonData) {
        if (filter(entry as Map<String, dynamic>)) {
          final T? obj = fromJson(entry);

          if (obj != null) {
            results.add(obj);
          }
        }
      }
    }

    return results;
  }

  Future<void> insert(T model, Map<String, dynamic> Function(T) toJson) async {
    final filePath = _getFilePath();
    final data = await _fileStorage.readFromFile(filePath);

    final dataList = data[_category] as List<dynamic>? ?? []
      ..add(toJson(model));

    await _fileStorage.writeToFile(filePath, {_category: dataList});
  }

  Future<void> delete(bool Function(dynamic) filter) async {
    final filePath = _getFilePath();
    final data = await _fileStorage.readFromFile(filePath);

    final dataList = data[_category] as List<dynamic>? ?? []
      ..removeWhere(
        (entry) {
          return filter(entry);
        },
      );

    await _fileStorage.writeToFile(filePath, {_category: dataList});
  }

  String _getFilePath() {
    return path.join(_baseDir, '${_category.toLowerCase()}.json');
  }
}
