import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "Binay Das";
  String userEmail = "binaypicture@example.com";
  String userPhone = "+1234567890";

  // Function to show edit dialog
  void _editField(String field, String value, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: value);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $field"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Profile"), backgroundColor: Colors.purpleAccent),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/profile.png"),
            ),
            const SizedBox(height: 20),

            // Editable User Info
            ListTile(
              title: Text("Name"),
              subtitle: Text(userName),
              trailing: Icon(Icons.edit),
              onTap: () => _editField("Name", userName, (value) {
                setState(() => userName = value);
              }),
            ),
            const Divider(),
            ListTile(
              title: Text("Email"),
              subtitle: Text(userEmail),
              trailing: Icon(Icons.edit),
              onTap: () => _editField("Email", userEmail, (value) {
                setState(() => userEmail = value);
              }),
            ),
            const Divider(),
            ListTile(
              title: Text("Phone"),
              subtitle: Text(userPhone),
              trailing: Icon(Icons.edit),
              onTap: () => _editField("Phone", userPhone, (value) {
                setState(() => userPhone = value);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
