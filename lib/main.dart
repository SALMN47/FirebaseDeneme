import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_india/homepage.dart';
import 'package:firebase_india/pages/first.dart';
import 'package:firebase_india/pages/log%C4%B1n.dart';
import 'package:firebase_india/pages/signup.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class DefaultFirebaseOptions {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LogInPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage()
      },
      home: LogInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
