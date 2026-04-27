import 'package:flutter/material.dart';
import 'package:pharmacy/screens/login_screen.dart';

void main() {
  runApp(const PharmacyApp());
}

class PharmacyApp extends StatelessWidget {
  const PharmacyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Pharmacy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}