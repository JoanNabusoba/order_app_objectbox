import 'package:order_app_objectbox/model/user.dart';
import 'package:order_app_objectbox/objectbox.g.dart';

class ObjectBox {
  //open store to store data inside
  late final Store _store;
  //use store to store our user inside
  late final Box<User> _userBox;

  ObjectBox._init(this._store) {
    //initialize
    _userBox = Box<User>(_store);
  }
  static Future<ObjectBox> init() async {
    final store = await openStore();

    return ObjectBox._init(store);
  }

  //methods to get user, insert and delete
  User? getUser(int id) => _userBox.get(id);

  int insertUser(User user) => _userBox.put(user);

  bool deleteUser(int id) => _userBox.remove(id);

  //read user from db
  Stream<List<User>> getUsers() => _userBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());
}
