import 'package:attendance_app/home_screen.dart';
import 'package:attendance_app/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// void testFirestore() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   await firestore.collection("test").add({"message": "hello"});
//   print("firestore success");
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Attendance app';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
