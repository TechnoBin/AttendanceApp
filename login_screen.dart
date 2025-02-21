import 'package:attendance_app/home_screen.dart';

import 'package:attendance_app/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorMessage;

  // Function to handle login
  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock, size: 100, color: Colors.white),
                const SizedBox(height: 20),
                const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 6)
                    ],
                  ),
                  child: TextField(
                    controller: _emailController,
                    // keyboardType: TextInputType,
                    decoration: InputDecoration(
                      hintText: "Enter E-mail",
                      prefixIcon: const Icon(Icons.mail, color: Colors.blue),
                      border: InputBorder.none,
                      errorText: _errorMessage != null
                          ? 'Invalid email or password'
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 6)
                    ],
                  ),
                  child: TextField(
                    controller: _passwordController,
                    // keyboardType: TextInputType,
                    decoration: const InputDecoration(
                      hintText: "Enter Password",
                      prefixIcon: Icon(Icons.password, color: Colors.blue),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Login",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: const Text('Don\'t have an account? Sign Up'),
                )
//             ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
