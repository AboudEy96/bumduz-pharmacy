import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/Service/UserService.dart';
import 'package:pharmacy/abbreviations/MySnackBar.dart';
import 'package:pharmacy/models/User/User.dart';
import 'package:pharmacy/models/User/UserBuilder.dart';
import 'package:pharmacy/screens/pharmacist_home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String selectedRole = "patient";

  Future<void> register() async {
    MySnackBar.send(context, "register clicked.");

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      MySnackBar.send(context, "Please fill all fields");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      MySnackBar.send(context, "Password does not match");
      return;
    }

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final uid = credential.user!.uid;

      var us1 = UserBuilder()
          .setId(uid.hashCode)
          .setEmail(emailController.text)
          .setPassword(passwordController.text)
          .setName(nameController.text)
          .setRole(selectedRole)
          .build();

      await UserService().addUserWithUid(uid, us1);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PharmacistHomeScreen(userName: us1.name),
        ),
      );

      MySnackBar.send(context, "Welcome ${us1.name} !");
    } catch (e) {
      MySnackBar.send(context, "Error: $e");
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F6),
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [

                const Icon(
                  Icons.person_add,
                  size: 72,
                  color: Colors.teal,
                ),

                const SizedBox(height: 16),

                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                buildTextField(
                  controller: nameController,
                  label: "Full Name",
                  icon: Icons.person,
                ),

                buildTextField(
                  controller: emailController,
                  label: "Email",
                  icon: Icons.email,
                ),

                buildTextField(
                  controller: passwordController,
                  label: "Password",
                  icon: Icons.lock,
                  obscureText: true,
                ),

                buildTextField(
                  controller: confirmPasswordController,
                  label: "Confirm Password",
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),

                const SizedBox(height: 12),

                DropdownButtonFormField(
                  value: selectedRole,
                  items: const [
                    DropdownMenuItem(
                      value: "patient",
                      child: Text("Patient"),
                    ),
                    DropdownMenuItem(
                      value: "pharmacist",
                      child: Text("Pharmacist"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Role",
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
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 18),
                    ),
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