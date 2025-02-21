import 'package:attendance_app/login_screen.dart';
import 'package:attendance_app/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? _image;
  final picker = ImagePicker();
  bool isDarkMode = false;

  String userName = "Binay";

  void _toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }
  void _addAccount() {
    print("Add Account Clicked");
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Settings",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section with Gradient Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: ListTile(
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                  title: Text(
                    userName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("bin@gmail.com",
                      style: TextStyle(color: Colors.white70)),
                  trailing: const Icon(Icons.edit, color: Colors.white),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()));
                  }),
            ),

            const SizedBox(height: 20),

            // Settings Options with Card Design
            _buildSettingsCard([
              _buildSettingsItem(Icons.dark_mode, "Dark Mode",
                  trailing: Switch(value: isDarkMode, onChanged: _toggleTheme)),
              _buildSettingsItem(Icons.notifications, "Notifications"),
              _buildSettingsItem(Icons.lock, "Privacy"),
            ]),

            _buildSettingsCard([
              _buildSettingsItem(Icons.person_add, "Add Account",
                  onTap: _addAccount),
              _buildSettingsItem(Icons.logout, "Log Out",
                  iconColor: Colors.red, textColor: Colors.red, onTap: logout),
            ]),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(children: children),
    );
  }

  Widget _buildSettingsItem(IconData icon, String text,
      {Widget? trailing,
      Color iconColor = Colors.black,
      Color textColor = Colors.black,
      Function()? onTap}) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
      trailing: trailing ??
          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
      onTap: onTap,
    );
  }
}
