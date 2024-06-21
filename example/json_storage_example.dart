import 'models/itens_model.dart';
import 'models/user_model.dart';
import 'orms/item_orm.dart';
import 'orms/user_orm.dart';

void main() async {
  final String baseDir = 'path/to/your/base/dir';

  final UserORM userOrm = UserORM(baseDir);
  final ItemORM itemOrm = ItemORM(baseDir);

  UserModel user1 = UserModel(name: 'Alice', age: 30);
  UserModel user2 = UserModel(name: 'Bob', age: 25);
  UserModel user3 = UserModel(name: 'Charlie', age: 35);

  IconModel icon1 = IconModel(id: 1, fileName: 'icon1.png');
  IconModel icon2 = IconModel(id: 2, fileName: 'icon2.png');
  IconModel icon3 = IconModel(id: 3, fileName: 'icon3.png');

  ItemModel item1 = ItemModel(name: 'Item 1', price: 10.0, icon: icon1);
  ItemModel item2 = ItemModel(name: 'Item 2', price: 10.0, icon: icon2);
  ItemModel item3 = ItemModel(name: 'Item 3', price: 10.0, icon: icon3);

  await userOrm.insert(user1);
  await userOrm.insert(user2);
  await userOrm.insert(user3);

  await itemOrm.insert(item1);
  await itemOrm.insert(item2);
  await itemOrm.insert(item3);

  await userOrm.delete((user) => user.name == 'Alice');
  await itemOrm.delete((item) => item.name == 'Item 1');

  List<UserModel> usersWithNameBob = await userOrm.query((user) => user.name == 'Bob');

  usersWithNameBob.forEach((user) {
    print('User found: ${user.name}, ${user.age}');
  });

  List<ItemModel> itemsWithNameItem2 = await itemOrm.query((item) => item.name == 'Item 2');

  itemsWithNameItem2.forEach((item) {
    print('Item found: ${item.name}, ${item.price}, ${item.icon}');
  });

  List<UserModel> allUsers = await userOrm.query((user) => true);

  allUsers.forEach((user) {
    print('User: ${user.name}, ${user.age}');
  });

  List<ItemModel> allItems = await itemOrm.query((item) => true);

  allItems.forEach((item) {
    print('Item: ${item.name}, ${item.price}, ${item.icon.id}');
  });
}
