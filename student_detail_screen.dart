// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class StudentDetailScreen extends StatefulWidget {
//   final String name;
//   final String rollNo;
//   final String studentClass;

//   StudentDetailScreen(
//       {required this.name, required this.rollNo, required this.studentClass});

//   @override
//   _StudentDetailScreenState createState() => _StudentDetailScreenState();
// }

// class _StudentDetailScreenState extends State<StudentDetailScreen> {
//   String qrData = "Loading QR Code...";

//   @override
//   void initState() {
//     super.initState();
//     _loadQRCode();
//   }

//   void _loadQRCode() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? storedQRData = prefs.getString("qr_codes");

//     if (storedQRData != null && storedQRData.isNotEmpty) {
//       try {
//         Map<String, dynamic> qrCodes = jsonDecode(storedQRData);
//         setState(() {
//           qrData = qrCodes.containsKey(widget.name)
//               ? qrCodes[widget.name]
//               : "QR Code not found!";
//         });
//       } catch (e) {
//         print("json decode error: $e");
//         setState(() {
//           qrData = "QR Code not found";
//         });
//       }
//     } else {
//       setState(() {
//         qrData = "QR Code not found";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Student Details")),
//       body: Padding(
//           padding: EdgeInsets.all(20),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Student Details",
//                     style:
//                         TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 20),

//                 // QR Code
//                 qrData != "QR Code not found!"
//                     ? QrImageView(
//                         data: qrData,
//                         size: 200,
//                         backgroundColor: Colors.white,
//                       )
//                     : Text("QR Code not found!",
//                         style: TextStyle(color: Colors.red, fontSize: 16)),

//                 SizedBox(height: 20),

//                 // Student Information
//                 Text("Name: ${widget.name}", style: TextStyle(fontSize: 18)),
//                 Text("Roll No: ${widget.rollNo}",
//                     style: TextStyle(fontSize: 18)),
//                 Text("Class: ${widget.studentClass}",
//                     style: TextStyle(fontSize: 18)),

//                 SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text("Back"),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StudentDetailScreen extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const StudentDetailScreen({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Details")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${studentData['name']}",
                style: const TextStyle(fontSize: 18)),
            Text("Class: ${studentData['className']}",
                style: const TextStyle(fontSize: 18)),
            Text("Roll No: ${studentData['rollNumber']}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Center(
              child: QrImageView(
                data: studentData['qrData'], // Generate QR from stored text
                version: QrVersions.auto,
                size: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
