import 'package:json_storage/json_storage.dart';

import '../models/user_model.dart';

class UserORM implements ORMInterface<UserModel> {
  UserORM(String baseDir) {
    _jsonOrm = JsonORM<UserModel>(baseDir, 'users');
  }

  late JsonORM<UserModel> _jsonOrm;

  @override
  Future<List<UserModel>> query(bool Function(UserModel) filter) async {
    return _jsonOrm.query((data) => filter(UserModel.fromJson(data)), UserModel.fromJson);
  }

  @override
  Future<void> insert(UserModel user) async {
    await _jsonOrm.insert(user, (user) => user.toJson());
  }

  @override
  Future<void> delete(bool Function(UserModel) filter) async {
    await _jsonOrm.delete(
      (data) => filter(
        UserModel.fromJson(data as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<void> update(bool Function(UserModel) filter, UserModel Function(UserModel) updateFields) async {
    await _jsonOrm.update(
      (data) => filter(UserModel.fromJson(data)),
      (data) => updateFields(UserModel.fromJson(data)),
    );
  }
}
