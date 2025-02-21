import 'package:flutter/material.dart';
import 'package:attendance_app/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailScreen extends StatefulWidget {
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isEmailVerified = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkEmailVerification();
  }

  // Check if the user's email is verified
  Future<void> _checkEmailVerification() async {
    User? user = _auth.currentUser;
    await user?.reload();
    setState(() {
      _isEmailVerified = user?.emailVerified ?? false;
    });

    if (_isEmailVerified) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
  }

  // Resend email verification link
  Future<void> _resendVerificationEmail() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      print("Error sending email: $e");
    }

    setState(() {
      _isLoading = false;
    });
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
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'A verification email has been sent to your email address.\nPlease check your inbox and verify.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _checkEmailVerification,
                child: const Text('I have verified my email'),
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _resendVerificationEmail,
                      child: const Text('Resend Email'),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
