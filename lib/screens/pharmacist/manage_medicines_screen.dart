import 'package:flutter/material.dart';

class ManageMedicinesScreen extends StatelessWidget {
  const ManageMedicinesScreen({super.key});

  final List<Map<String, String>> medicines = const [
    {
      'name': 'Paracetamol',
      'dosage': '500 mg',
      'time': '08:00 AM',
      'quantity': '12',
      'patient': 'Patient ID: 1',
    },
    {
      'name': 'Vitamin D',
      'dosage': '1000 IU',
      'time': '01:00 PM',
      'quantity': '20',
      'patient': 'Patient ID: 1',
    },
    {
      'name': 'Amoxicillin',
      'dosage': '250 mg',
      'time': '09:00 PM',
      'quantity': '8',
      'patient': 'Patient ID: 2',
    },
  ];

  void showMockMessage(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action feature is UI only (Mock Data)'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F6),
      appBar: AppBar(
        title: const Text('Manage Medicines'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          final medicine = medicines[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE0F2F1),
                child: Icon(
                  Icons.inventory,
                  color: Colors.teal,
                ),
              ),
              title: Text(
                medicine['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Dosage: ${medicine['dosage']}\n'
                'Time: ${medicine['time']}\n'
                'Quantity: ${medicine['quantity']}\n'
                '${medicine['patient']}',
              ),
              isThreeLine: true,
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  showMockMessage(context, value);
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'Update',
                    child: Text('Update'),
                  ),
                  PopupMenuItem(
                    value: 'Delete',
                    child: Text('Delete'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
