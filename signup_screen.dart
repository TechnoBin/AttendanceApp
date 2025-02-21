import 'package:attendance_app/verify_email_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorMessage;
  bool _isLoading = false;

  // Function to handle signup with OTP verification
  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Passwords do not match";
      });
      return;
    }

    try {
      // Create user in Firebase
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Send email verification (OTP link)
      await userCredential.user!.sendEmailVerification();

      setState(() {
        _isLoading = false;
      });

      // Navigate to the verification page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VerifyEmailScreen()),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
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
            colors: [Colors.purple, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create Your Account",
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
                    decoration: const InputDecoration(
                      hintText: "Email Address",
                      prefixIcon: Icon(Icons.mail, color: Colors.purple),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
                SizedBox(height: 16),
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
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Create Password",
                      prefixIcon:
                          Icon(Icons.password_rounded, color: Colors.purple),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 6)
                    ],
                  ),
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Confirm Password",
                      prefixIcon:
                          Icon(Icons.password_rounded, color: Colors.purple),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Sign Up",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(_errorMessage!,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 7, 7, 7))),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
