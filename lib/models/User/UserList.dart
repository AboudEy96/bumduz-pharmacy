import 'package:pharmacy/models/User/User.dart';

class UserList {

  // singletoon userlist
  static final UserList _instance = UserList._internal();

  factory UserList() {
    return _instance;
  }
  UserList._internal();

  // start for new empty user list
  List<User> _users = [];

  // add and remove and get users form list
  void addUser(User user) {
    _users.add(user);
  }

  void removeUser(User user) {
    _users.remove(user);
  }

  List<User> getUsersList() {
    return _users;
  }

  /*search for user by his username
  TODO: don't search for entire array.. sort the list from A-Z letters and get first latter from username
   */
  User? getUserByName(String username) {
    if (username.isEmpty) return null;

    for (var user in _users) {
      if (user.name == username) {
        return user;
      }
    }
    return null;
  }
}