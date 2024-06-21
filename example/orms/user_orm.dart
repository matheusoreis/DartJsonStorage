import 'package:json_storage/json_storage.dart';

import '../models/user_model.dart';

class UserORM implements ORMInterface<UserModel> {
  late JsonORM<UserModel> _jsonOrm;

  UserORM(String baseDir) {
    _jsonOrm = JsonORM<UserModel>(baseDir, 'users');
  }

  Future<List<UserModel>> query(bool Function(UserModel) filter) async {
    return _jsonOrm.query((data) => filter(UserModel.fromJson(data)), (json) => UserModel.fromJson(json));
  }

  Future<void> insert(UserModel user) async {
    await _jsonOrm.insert(user, (user) => user.toJson());
  }

  Future<void> delete(bool Function(UserModel) filter) async {
    await _jsonOrm.delete((data) => filter(UserModel.fromJson(data)));
  }
}
