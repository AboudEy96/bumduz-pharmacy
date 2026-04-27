import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/Service/UserService.dart';
import 'package:pharmacy/models/User/User.dart';
import 'package:pharmacy/models/User/UserBuilder.dart';
import 'pharmacist_view.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

// await Firebase.initializeApp(options:
// DefaultFirebaseOptions.currentPlatform);


  // testUsers();

  runApp(const MaterialApp(
    home: PharmacistView(),
  ));
}
Future<void> testUsers() async
{
  // how to create user
  User us1 = new UserBuilder().setId(1).setName("Abdulkadir").setRole("pharmacist").build();
  User us2 = new UserBuilder().setId(2).setName("Mohammed").setRole("patient").build();
  User us3 = new UserBuilder().setId(3).setName("Moaz").setRole("rpharmacist").build();
  User us4 = new UserBuilder().setId(4).setName("abdullah").setRole("pharmacistAPP").build();
  await UserService().addUser(us1);
  await UserService().addUser(us4);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
