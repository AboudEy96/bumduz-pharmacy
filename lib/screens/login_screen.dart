import 'package:flutter/material.dart';
import 'package:pharmacy/data/mock_users.dart';
import 'package:pharmacy/screens/patient_home_screen.dart';
import 'package:pharmacy/screens/pharmacist_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  void login() {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage('Please enter email and password');
      return;
    }

    final user = mockUsers.where((user) {
      return user['email'] == email && user['password'] == password;
    }).toList();

    if (user.isEmpty) {
      showMessage('Invalid email or password');
      return;
    }

    final loggedUser = user.first;
    final String name = loggedUser['name'] ?? '';
    final String role = loggedUser['role'] ?? '';

    if (role == 'pharmacist') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PharmacistHomeScreen(userName: name),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PatientHomeScreen(userName: name),
        ),
      );
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_pharmacy,
                      size: 72,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Smart Pharmacy',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Mock Login',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 32),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Test accounts:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'patient@test.com / 123456\npharmacist@test.com / 123456',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}