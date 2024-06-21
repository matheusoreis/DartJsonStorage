import 'package:json_storage/json_storage.dart';

import '../models/itens_model.dart';

class ItemORM implements ORMInterface<ItemModel> {
  late JsonORM<ItemModel> _jsonOrm;

  ItemORM(String baseDir) {
    _jsonOrm = JsonORM<ItemModel>(baseDir, 'itens');
  }

  Future<List<ItemModel>> query(bool Function(ItemModel) filter) async {
    return _jsonOrm.query((data) => filter(ItemModel.fromJson(data)), (json) => ItemModel.fromJson(json));
  }

  Future<void> insert(ItemModel user) async {
    await _jsonOrm.insert(user, (user) => user.toJson());
  }

  Future<void> delete(bool Function(ItemModel) filter) async {
    await _jsonOrm.delete((data) => filter(ItemModel.fromJson(data)));
  }
}
