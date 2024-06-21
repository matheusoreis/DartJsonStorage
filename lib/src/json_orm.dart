import 'package:path/path.dart' as path;
import 'package:json_storage/src/file_storage.dart';

class JsonORM<T> {
  late String _baseDir;
  late FilesStorage _fileStorage;
  late String _category;

  JsonORM(String baseDir, String category) {
    _baseDir = baseDir;
    _category = category;
    _fileStorage = FilesStorage(baseDir);
  }

  Future<List<T>> query(bool Function(Map<String, dynamic>) filter, T Function(Map<String, dynamic>) fromJson) async {
    List<T> results = [];

    String filePath = _getFilePath();
    Map<String, dynamic>? data = await _fileStorage.readFromFile(filePath);

    if (data.containsKey(_category)) {
      List<dynamic> jsonData = data[_category];
      jsonData.forEach((entry) {
        if (filter(entry)) {
          T? obj = fromJson(entry as Map<String, dynamic>);
          if (obj != null) {
            results.add(obj);
          }
        }
      });
    }

    return results;
  }

  Future<void> insert(T model, Map<String, dynamic> Function(T) toJson) async {
    String filePath = _getFilePath();
    Map<String, dynamic>? data = await _fileStorage.readFromFile(filePath);

    List<dynamic> dataList = data[_category] ?? [];

    dataList.add(toJson(model));

    await _fileStorage.writeToFile(filePath, {_category: dataList});
  }

  Future<void> delete(bool Function(dynamic) filter) async {
    String filePath = _getFilePath();
    Map<String, dynamic>? data = await _fileStorage.readFromFile(filePath);

    List<dynamic> dataList = data[_category] ?? [];

    dataList.removeWhere((entry) => filter(entry));

    await _fileStorage.writeToFile(filePath, {_category: dataList});
  }

  String _getFilePath() {
    return path.join(_baseDir, '${_category.toLowerCase()}.json');
  }
}
