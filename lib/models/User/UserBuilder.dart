import 'package:pharmacy/models/User/User.dart';

class UserBuilder {
  int? _id;
  String? _name;
  String? _role;
  String? _email;
  String? _password;
  UserBuilder setId(int id) {
    _id = id;
    return this;
  }

  UserBuilder setName(String name) {
    _name = name;
    return this;
  }

  UserBuilder setRole(String role) {
    _role = role;
    return this;
  }
  UserBuilder setPassword(String password) {
    _password = password;
    return this;
  }
  UserBuilder setEmail(String mail) {
    _email = mail;
    return this;
  }

  User build() {
    if (_id == null || _name == null || _role == null) {
      throw Exception("please enter all fields [id, name, role]");
    }

    User user = User(
      id: _id!,
      name: _name!,
      role: _role!,
      email: _email!,
      password: _password!,
    );
    return user;
  }
}