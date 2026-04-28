import 'package:flutter/material.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  final List<Map<String, String>> reminders = const [
    {
      'medicine': 'Paracetamol',
      'time': '08:00 AM',
      'status': 'Today',
    },
    {
      'medicine': 'Vitamin D',
      'time': '01:00 PM',
      'status': 'Today',
    },
    {
      'medicine': 'Amoxicillin',
      'time': '09:00 PM',
      'status': 'Tonight',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE0F2F1),
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.teal,
                ),
              ),
              title: Text(
                reminder['medicine']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Time: ${reminder['time']}'),
              trailing: Text(
                reminder['status']!,
                style: const TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
