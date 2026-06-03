import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy/models/Medicine/Medicine.dart';
import 'package:pharmacy/service/MedicineService.dart';
import 'package:pharmacy/screens/pharmacist/add_medicine_screen.dart';

class MyMedicinesScreen extends StatelessWidget {
  const MyMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final service = MedicineService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Medicines'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Medicine>>(
        stream: service.getMedicines(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('NO MEDICINES click on (+) to add'));
          }

          final medicines = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final m = medicines[index];
              final int quantity = int.tryParse(m.quantity.toString()) ?? 0;
              final int dosage = int.tryParse(m.dosage.toString()) ?? 1;
              final bool taken = m.takenToday;
              final bool outOfStock = quantity <= 0;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: taken
                            ? Colors.green.shade100
                            : const Color(0xFFE0F2F1),
                        child: Icon(
                          taken ? Icons.check : Icons.medication,
                          color: taken ? Colors.green : Colors.teal,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              m.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('Dosage: ${m.dosage} mg Time: ${m.time}'),
                            Text(
                              'Remaining: $quantity tablets',
                              style: TextStyle(
                                color: outOfStock ? Colors.red : Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: (taken || outOfStock)
                            ? null
                            : () async {
                          final newQty = quantity - dosage;
                          await service.takeMedicine(
                            userId,
                            m.id!,
                            newQty < 0 ? 0 : newQty,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: taken ? Colors.green : Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Icon(
                          taken ? Icons.check : Icons.done,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddMedicineScreen(isPharmacist: false,)),
        ),
      ),
    );
  }
}