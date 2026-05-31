import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy/models/User/User.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = cred.user!.uid;
    return getUserById(uid);
  }
  Future<void> addUser(User user) async {
    final docRef = _db.collection('users').doc(user.id.toString());

    final doc = await docRef.get();

    if (doc.exists) {
      throw Exception("User already exists");
    }
//..,,.,.,.
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
        email: data['email'],
        password: data['password']
      );
    }).toList();
  }
  Future<void> addUserWithUid(String uid, User user) async {
    await _db.collection('users').doc(uid).set(user.toMap());
  }

  Future<User?> getUserById(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return User.fromMap(doc.data()!);
  }

  Future<void> deleteUser(int id) async {
    await _db.collection('users').doc(id.toString()).delete();
  }


}