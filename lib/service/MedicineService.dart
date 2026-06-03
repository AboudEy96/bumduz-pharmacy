import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy/models/Medicine/Medicine.dart';

class MedicineService {
  final _db = FirebaseFirestore.instance;

  // users/userID/medicines/medic..
  CollectionReference _medicinesRef(String userId) =>
      _db.collection('users').doc(userId).collection('medicines');

  Future<void> addMedicine(String userId, Medicine medicine) async {
    await _medicinesRef(userId).doc(medicine.name).set(medicine.toMap());
  }

  Stream<List<Medicine>> getMedicines(String userId) {
    return _medicinesRef(userId).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) =>
            Medicine.fromMap(doc.id, doc.data() as Map<String, dynamic>)
        ).toList()
    );
  }
  Future<void> takeMedicine(String userId, String medicineId, int newQuantity) async {
    await _medicinesRef(userId).doc(medicineId).update({
      'quantity': newQuantity,
      'takenToday': true,
    });
  }
}