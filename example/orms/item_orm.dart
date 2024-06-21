import 'package:json_storage/json_storage.dart';

import '../models/itens_model.dart';

class ItemORM implements ORMInterface<ItemModel> {
  ItemORM(String baseDir) {
    _jsonOrm = JsonORM<ItemModel>(baseDir, 'itens');
  }

  late JsonORM<ItemModel> _jsonOrm;

  @override
  Future<List<ItemModel>> query(bool Function(ItemModel) filter) async {
    return _jsonOrm.query((data) => filter(ItemModel.fromJson(data)), ItemModel.fromJson);
  }

  @override
  Future<void> insert(ItemModel user) async {
    await _jsonOrm.insert(user, (user) => user.toJson());
  }

  @override
  Future<void> delete(bool Function(ItemModel) filter) async {
    await _jsonOrm.delete(
      (data) => filter(
        ItemModel.fromJson(
          data as Map<String, dynamic>,
        ),
      ),
    );
  }

  @override
  Future<void> update(bool Function(ItemModel) filter, ItemModel Function(ItemModel) updateFields) async {
    await _jsonOrm.update(
      (data) => filter(ItemModel.fromJson(data)),
      (data) => updateFields(ItemModel.fromJson(data)),
    );
  }
}
