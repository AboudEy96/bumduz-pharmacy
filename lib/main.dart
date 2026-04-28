import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/Service/UserService.dart';
import 'package:pharmacy/firebase_options.dart';
import 'package:pharmacy/models/User/User.dart';
import 'package:pharmacy/models/User/UserBuilder.dart';
import 'package:pharmacy/screens/login_screen.dart';

 void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  testUsers();
  runApp(const PharmacyApp());

}
Future<void> testUsers() async
{
  // how to create user
  User us1 = new UserBuilder().setId(1).setName("Abdulkadir").setRole("pharmacist").build();
  User us2 = new UserBuilder().setId(2).setName("Mohammed").setRole("patient").build();
  User us3 = new UserBuilder().setId(3).setName("Moaz").setRole("rpharmacist").build();


  try {
    await UserService().addUser(us1);
  } catch (e) {
    print("us1 failed: $e");
  }
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