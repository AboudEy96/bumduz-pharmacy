import 'package:flutter/material.dart';

class MyMedicinesScreen extends StatelessWidget {
  const MyMedicinesScreen({super.key});

  final List<Map<String, String>> medicines = const [
    {
      'name': 'Paracetamol',
      'dosage': '500 mg',
      'time': '08:00 AM',
      'quantity': '12 tablets',
    },
    {
      'name': 'Vitamin D',
      'dosage': '1000 IU',
      'time': '01:00 PM',
      'quantity': '20 capsules',
    },
    {
      'name': 'Amoxicillin',
      'dosage': '250 mg',
      'time': '09:00 PM',
      'quantity': '8 capsules',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Medicines'),
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
                  Icons.medication,
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
                'Dosage: ${medicine['dosage']}\nTime: ${medicine['time']}',
              ),
              trailing: Text(
                medicine['quantity']!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
