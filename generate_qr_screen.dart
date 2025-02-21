import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddNewStudentScreen extends StatefulWidget {
  const AddNewStudentScreen({super.key});

  @override
  _AddNewStudentScreenState createState() => _AddNewStudentScreenState();
}

class _AddNewStudentScreenState extends State<AddNewStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool isLoading = false;
  // final StudentService _studentService = StudentService();

  Future<void> addStudent() async {
    if (_nameController.text.isEmpty || _classController.text.isEmpty) {
      return; // Show validation error
    }

    String studentId = Uuid().v4(); // Unique ID for student
    String qrData = "StudentID: $studentId\n"
        "Name: ${_nameController.text}\n"
        "Class: ${_classController.text}";

    Map<String, dynamic> studentData = {
      "studentId": studentId,
      "name": _nameController.text,
      "className": _classController.text,
      "rollNumber": _rollNoController.text,
      "parentName": _parentNameController.text,
      "address": _addressController.text,
      "qrData": qrData, // Store QR text instead of image
    };

    // Store student data in Firestore
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("classes")
        .doc(studentData['className'])
        .collection("students")
        .doc(studentId)
        .set(studentData);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add New Student")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Student Name"),
                ),
                TextField(
                  controller: _rollNoController,
                  decoration: const InputDecoration(labelText: "Roll No."),
                ),
                TextField(
                  controller: _classController,
                  decoration: const InputDecoration(labelText: "Class"),
                ),
                TextField(
                  controller: _parentNameController,
                  decoration: const InputDecoration(labelText: "Parent Name"),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: "Address"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : addStudent,
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text("Add Student"),
                ),
              ],
            ),
          ),
        ));
  }
}

String generateQRCodeValue() {
  return DateTime.now().millisecondsSinceEpoch.toString(); // Unique QR Code ID
}
