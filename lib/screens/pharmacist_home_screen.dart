import 'package:flutter/material.dart';

class PharmacistHomeScreen extends StatelessWidget {
  final String userName;

  const PharmacistHomeScreen({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacist Home'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Dr. $userName',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Role: Pharmacist',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            Card(
              child: ListTile(
                leading: const Icon(Icons.add_box),
                title: const Text('Add Medicine'),
                subtitle: const Text('Add new medicine to the system'),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.inventory),
                title: const Text('Manage Medicines'),
                subtitle: const Text('Update or delete medicine records'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
