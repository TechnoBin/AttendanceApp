// import 'package:attendance_app/student_detail_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class StudentListScreen extends StatefulWidget {
//   final String className;

//   StudentListScreen({required this.className});

//   @override
//   _StudentListScreenState createState() => _StudentListScreenState();
// }

// class _StudentListScreenState extends State<StudentListScreen> {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   // List<String> allStudents = [];
//   // List<String> presentStudents = [];
//   // List<String> absentStudents = [];

//   @override
//   void initState() {
//     super.initState();
//     // _loadAttendance();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // _loadAttendance();
//   }

//   // void _loadAttendance() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   List<String> savedStudents = prefs.getStringList(widget.className) ?? [];
//   //   //List<String> attendanceList = prefs.getStringList("attendanceList") ?? [];
//   //   List<String> presentStudents = prefs.getStringList("") ?? [];

//     // setState(() {
//     //   allStudents = savedStudents;
//     //   this.presentStudents = presentStudents;
//     //   absentStudents =
//     //       savedStudents.where((s) => !presentStudents.contains(s)).toList();

//     // });
//   }

//   // void _deleteStudent(String student) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   List<String> savedStudents = prefs.getStringList(widget.className) ?? [];

//   //   savedStudents.remove(student); // Remove student from list
//   //   await prefs.setStringList(widget.className, savedStudents);
//   //   // List<String> attendanceList = prefs.getStringList("attendanceList") ?? [];
//   //   // attendanceList.remove(student);
//   //   // await prefs.setStringList("attendanceList", attendanceList);

//   //   // Update storage

//   //   setState(() {
//   //     allStudents = savedStudents; // Refresh list
//   //   });

//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(content: Text("$student removed!"), backgroundColor: Colors.red),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3, // 3 Tabs
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Class ${widget.className} - Students"),
//           // actions: [
//           //   IconButton(
//           //       onPressed: () {
//           //         setState(() {
//           //           _loadAttendance();
//           //         });
//           //       },
//           //       icon: Icon(Icons.refresh))
//           // ],
//           bottom: TabBar(
//             tabs: [
//               Tab(text: "Total"),
//               Tab(text: "Present"),
//               Tab(text: "Absent"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildStudentList("Total Students"),
//             _buildStudentList("Present Students",
//                 color: Colors.green),
//             _buildStudentList("Absent Students",
//                 color: Colors.red),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStudentList( String filter,
//       {Color color = Colors.black}) {
//     return Padding(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Text(students.length,
//           //     style: TextStyle(
//           //         fontSize: 18, fontWeight: FontWeight.bold, color: color)),
//           SizedBox(height: 10),
//           Expanded(
//             child: StreamBuilder(
//         stream: _firestore
//             .collection("classes")
//             .doc(widget.className)
//             .collection("students")
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text("No students found"));
//           }

//           List<DocumentSnapshot> students = snapshot.data!.docs;

//           if (filter == "present") {
//             students = students.where((s) => s["present"] == true).toList();
//           } else if (filter == "absent") {
//             students = students.where((s) => s["present"] == false).toList();
//           }
//                 return ListView.builder(
//                     itemCount: students.length,
//                     itemBuilder: (context, index) {
//                       var student = students[index];
//                       // String studentName = studentEntry.split(", ")[0];

//                       return GestureDetector(
//                         onTap: () {

//                           // Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //       builder: (context) => StudentDetailScreen(
//                           //         name: studentData[0],
//                           //         rollNo: studentData.length > 1
//                           //             ? studentData[1]
//                           //             : "N/A",
//                           //         studentClass: widget.className,
//                           //       ),
//                           //     ));
//                         },
//                         onLongPress: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 title: Text("Delete Student"),
//                                 content: Text(
//                                     "Are you sure you want to remove ${student["name"]}?"),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () => Navigator.pop(context),
//                                     child: Text("Cancel"),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       _deleteStudent(student["name"]);
//                                       Navigator.pop(context); // Close dialog
//                                     },
//                                     child: Text("Delete",
//                                         style: TextStyle(color: Colors.red)),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         child: ListTile(
//                           title: Text(student["name"]),
//                           leading: Icon(
//                             color == Colors.green
//                                 ? Icons.check_circle
//                                 : (color == Colors.red
//                                     ? Icons.cancel
//                                     : Icons.person),
//                             color: color,
//                           ),
//                            trailing: Icon(student["present"] ? Icons.check_circle : Icons.cancel, color: student["present"] ? Colors.green : Colors.red),
//                 onTap: () {
//                   _toggleAttendance(student.id, student["present"]);
//                 },
//                         ),
//                       );
//                     },
//                   );}
//           ),)],),);}

// void _toggleAttendance(String studentId, bool isPresent) {
//       _firestore
//           .collection("classes")
//           .doc(widget.className)
//           .collection("students")
//           .doc(studentId)
//           .update({"present": !isPresent});
//     }
// }
//-----------------------------------------------------------------------------------------
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class StudentListScreen extends StatefulWidget {
//   final String className;
//   final String classId;
//   StudentListScreen({required this.classId, required this.className});

//   @override
//   _StudentListScreenState createState() => _StudentListScreenState();
// }

// class _StudentListScreenState extends State<StudentListScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("${widget.className} - Students"),
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: "Total"),
//               Tab(text: "Present"),
//               Tab(text: "Absent"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildStudentList("all"), // Total students tab
//             _buildStudentList("present"), // Present students tab
//             _buildStudentList("absent"), // Absent students tab
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStudentList(String filter) {
//     return StreamBuilder(
//       stream: _firestore
//           .collection("users")
//           .doc(userid)
//           .collection("classes")
//           .doc(widget.classId)
//           .collection("students")
//           .snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text("No students found"));
//         }

//         List<DocumentSnapshot> students = snapshot.data!.docs;

//         if (filter == "present") {
//           students = students.where((s) => s["present"] == true).toList();
//         } else if (filter == "absent") {
//           students = students.where((s) => s["present"] == false).toList();
//         }

//         return ListView.builder(
//           itemCount: students.length,
//           itemBuilder: (context, index) {
//             var student = students[index];
//             return ListTile(
//               title: Text(student["name"], style: TextStyle(fontSize: 18)),
//               trailing: Icon(
//                   student["present"] ? Icons.check_circle : Icons.cancel,
//                   color: student["present"] ? Colors.green : Colors.red),
//               onTap: () {
//                 _toggleAttendance(student.id, student["present"]);
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   void _toggleAttendance(String studentId, bool isPresent) {
//     _firestore
//         .collection("classes")
//         .doc(widget.className)
//         .collection("students")
//         .doc(studentId)
//         .update({"present": !isPresent});
//   }
// }
//-----------------------------------------------------------------------------------------
import 'package:attendance_app/student_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentListScreen extends StatefulWidget {
  final String classId;
  final String className;

  const StudentListScreen(
      {super.key, required this.classId, required this.className});

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot> getStudents() {
    String userId = _auth.currentUser!.uid;
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('classes')
        .doc(widget.classId)
        .collection('students')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.className),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Total"),
            Tab(text: "Present"),
            Tab(text: "Absent"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStudentList(), // Total Students
          _buildStudentList(filter: "present"), // Present Students
          _buildStudentList(filter: "absent"), // Absent Students
        ],
      ),
    );
  }

  Widget _buildStudentList({String? filter}) {
    return StreamBuilder<QuerySnapshot>(
      stream: getStudents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No students found."));
        }

        var studentDocs = snapshot.data!.docs;
        List<Map<String, dynamic>> studentList = studentDocs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return data;
        }).toList();

        if (filter == "present") {
          studentList =
              studentList.where((doc) => doc['isPresent'] == true).toList();
        } else if (filter == "absent") {
          studentList =
              studentList.where((doc) => doc['isPresent'] != true).toList();
        }

        return ListView.builder(
          itemCount: studentList.length,
          itemBuilder: (context, index) {
            var studentData = studentList[index];
            String studentName = studentData['name'];

            return Card(
              child: ListTile(
                title: Text(studentName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                onTap: () {
                  // Navigate to Student Detail Screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StudentDetailScreen(studentData: studentData)));
                },
              ),
            );
          },
        );
      },
    );
  }
}
