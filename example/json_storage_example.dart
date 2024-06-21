import 'models/itens_model.dart';
import 'models/user_model.dart';
import 'orms/item_orm.dart';
import 'orms/user_orm.dart';

void main() async {
  const baseDir = 'path/to/your/base/dir';

  final userOrm = UserORM(baseDir);
  final itemOrm = ItemORM(baseDir);

  final user1 = UserModel(name: 'Alice', age: 30);
  final user2 = UserModel(name: 'Bob', age: 25);
  final user3 = UserModel(name: 'Charlie', age: 35);

  final icon1 = IconModel(id: 1, fileName: 'icon1.png');
  final icon2 = IconModel(id: 2, fileName: 'icon2.png');
  final icon3 = IconModel(id: 3, fileName: 'icon3.png');

  final item1 = ItemModel(name: 'Item 1', price: 10, icon: icon1);
  final item2 = ItemModel(name: 'Item 2', price: 10, icon: icon2);
  final item3 = ItemModel(name: 'Item 3', price: 10, icon: icon3);

  await userOrm.insert(user1);
  await userOrm.insert(user2);
  await userOrm.insert(user3);

  await itemOrm.insert(item1);
  await itemOrm.insert(item2);
  await itemOrm.insert(item3);

  await userOrm.delete((user) => user.name == 'Alice');
  await itemOrm.delete((item) => item.name == 'Item 1');

  final usersWithNameBob = await userOrm.query((user) => user.name == 'Bob');

  for (final user in usersWithNameBob) {
    print('User found: ${user.name}, ${user.age}');
  }

  final itemsWithNameItem2 = await itemOrm.query((item) => item.name == 'Item 2');

  for (final item in itemsWithNameItem2) {
    print('Item found: ${item.name}, ${item.price}, ${item.icon}');
  }

  final allUsers = await userOrm.query((user) => true);

  for (final user in allUsers) {
    print('User: ${user.name}, ${user.age}');
  }

  final allItems = await itemOrm.query((item) => true);

  for (final item in allItems) {
    print('Item: ${item.name}, ${item.price}, ${item.icon.id}');
  }

  await userOrm.update((user) => user.name == 'Bob', (user) => UserModel(name: user.name, age: 26));

  await itemOrm.update((item) => item.name == 'Item 2', (item) => ItemModel(name: item.name, price: 20, icon: item.icon));
}
