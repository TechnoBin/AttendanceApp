import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStudent(String name, String rollNo, String className,
      String parentName, String address, String qrCodeUrl) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('students')
          .add({
        'name': name,
        'rollNo': rollNo,
        'class': className,
        'parentName': parentName,
        'address': address,
        'qrCode': qrCodeUrl,
        'attendance': [],
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding student: $e");
    }
  }
}
