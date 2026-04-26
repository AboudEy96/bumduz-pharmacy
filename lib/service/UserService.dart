import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy/models/User/User.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(User user) async {
    final docRef = _db.collection('users').doc(user.id.toString());

    final doc = await docRef.get();

    if (doc.exists) {
      throw Exception("User already exists");
    }

    await docRef.set(user.toMap());
  }

  Future<List<User>> getUsers() async {
    final snapshot = await _db.collection('users').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return User(
        id: data['id'],
        name: data['name'],
        role: data['role'],
      );
    }).toList();
  }

  Future<User?> getUserById(int id) async {
    final doc = await _db.collection('users').doc(id.toString()).get();

    if (!doc.exists) return null;

    final data = doc.data()!;

    return User(
      id: data['id'],
      name: data['name'],
      role: data['role'],
    );
  }

  Future<void> deleteUser(int id) async {
    await _db.collection('users').doc(id.toString()).delete();
  }
}