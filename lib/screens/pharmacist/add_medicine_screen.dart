import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy/models/Medicine/Medicine.dart';
import 'package:pharmacy/service/MedicineService.dart';

class AddMedicineScreen extends StatefulWidget {
  final bool isPharmacist;
  const AddMedicineScreen({super.key, this.isPharmacist = false});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController patientController = TextEditingController();

  bool _isLoading = false;

  Future<String?> _resolveUserId(String input) async {
    if (input.contains('@')) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: input)
          .limit(1)
          .get();
      if (snapshot.docs.isEmpty) return null;
      return snapshot.docs.first.id;
    }
    return input;
  }

  Future<void> saveMedicine() async {
    final String name = nameController.text.trim();
    final String dosage = dosageController.text.trim();
    final String time = timeController.text.trim();
    final String quantity = quantityController.text.trim();

    if (name.isEmpty || dosage.isEmpty || time.isEmpty || quantity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    String? userId;

    if (widget.isPharmacist) {
      final patient = patientController.text.trim();
      if (patient.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter patient UID or email')),
        );
        return;
      }
      userId = await _resolveUserId(patient);
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Patient not found'), backgroundColor: Colors.red),
        );
        return;
      }
    } else {
      userId = FirebaseAuth.instance.currentUser!.uid;
    }

    setState(() => _isLoading = true);

    try {
      final medicine = Medicine(
        name: name,
        dosage: dosage,
        time: time,
        quantity: quantity,
      );

      await MedicineService().addMedicine(userId!, medicine);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicine added successfully'), backgroundColor: Colors.teal),
      );

      nameController.clear();
      dosageController.clear();
      timeController.clear();
      quantityController.clear();
      patientController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    dosageController.dispose();
    timeController.dispose();
    quantityController.dispose();
    patientController.dispose();
    super.dispose();
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F6),
      appBar: AppBar(
        title: const Text('Add Medicine'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.add_box, size: 60, color: Colors.teal),
                const SizedBox(height: 12),
                const Text('Add New Medicine',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),

                if (widget.isPharmacist) ...[
                  buildTextField(
                    controller: patientController,
                    label: 'Patient UID or Email',
                    icon: Icons.person_search,
                  ),
                  const Divider(height: 8),
                  const SizedBox(height: 8),
                ],

                buildTextField(controller: nameController, label: 'Medicine Name', icon: Icons.medication),
                buildTextField(controller: dosageController, label: 'Dosage (mg)', icon: Icons.science, keyboardType: TextInputType.number),
                buildTextField(controller: timeController, label: 'Time', icon: Icons.access_time),
                buildTextField(controller: quantityController, label: 'Quantity (tablets)', icon: Icons.inventory, keyboardType: TextInputType.number),

                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : saveMedicine,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Save Medicine', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}