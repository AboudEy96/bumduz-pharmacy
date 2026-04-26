import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy/models/User/User.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(User user) async {
    await _db.collection('users').add({
      'id': user.id,
      'name': user.name,
      'role': user.role,
    });
  }

  Future<List<User>> getUsers() async {
    final snapshot = await _db.collection('users').get();

    return snapshot.docs.map((doc) {
      return User(
        id: doc['id'],
        name: doc['name'],
        role: doc['role'],
      );
    }).toList();
  }
}