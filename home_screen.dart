import 'package:attendance_app/generate_qr_screen.dart';
import 'package:attendance_app/scan_qr_screen.dart';
import 'package:attendance_app/settings_screen.dart';
import 'package:attendance_app/student_list_screen.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// @override
// void initState() {
//   super.initState();
//   _loadClasses();
// }

// void testFirestore() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   await firestore.collection("test").add({"message": "hello"});
//   print("firestore success");
// }

// @override
// void didChangeDependencies() {
//   super.didChangeDependencies();
//   //Check fror an update
//   // final bool? shouldUpdate =
//   //     ModalRoute.of(context)?.settings.arguments as bool?;
//   // if (shouldUpdate == true) {
//   //   _loadClasses(); //refresh homescreen
//   Future.microtask(() async {
//     final result = ModalRoute.of(context)?.settings.arguments;
//     if (result == true) {
//       _loadClasses();
//     }
//   });
// }

// void _loadClasses() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   Set<String> savedClasses =
//       prefs.getKeys(); //Get all class names (only if students exists)
//   // List<String> validClasses = [];
//   // for (String key in savedClasses) {
//   //   if (!key.startsWith("present_")) {
//   //     validClasses.add(key);
//   //   }
//   // }

//   setState(() {
//     classes = savedClasses
//         .where((key) =>
//             key != "classList" &&
//             key != "qr_codes" &&
//             !key.startsWith("present_"))
//         .toList();
//     // .where((Key) => Key != "qr_codes")
//     // .toList(); //convert set to list
//   });
// }

// void _renameClass(String oldClassName) async {
//   TextEditingController renameController =
//       TextEditingController(text: oldClassName);

//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text("Rename Class"),
//         content: TextField(controller: renameController),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () async {
//               SharedPreferences prefs = await SharedPreferences.getInstance();
//               List<String> students = prefs.getStringList(oldClassName) ?? [];

//               await prefs.remove(oldClassName); // Remove old class entry
//               await prefs.setStringList(
//                   renameController.text, students); // Save with new name

//               setState(() {
//                 classes.remove(oldClassName);
//                 classes.add(renameController.text);
//               });

//               Navigator.pop(context);
//             },
//             child: Text("Rename"),
//           ),
//         ],
//       );
//     },
//   );
// }

// void _deleteClass(String className) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove(className); // Remove class and students

//   setState(() {
//     classes.remove(className);
//   });

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(content: Text("Class Deleted"), backgroundColor: Colors.red),
//   );
// }

  @override
  Widget build(BuildContext context) {
    String userId = _auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              )
            : const Text("Attendance App"),
        actions: [
          _isSearching
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                ),
          PopupMenuButton<String>(
            offset: const Offset(-20, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onSelected: (value) {
              print("Selected: $value");
              // Handle menu option selection here
              if (value == "Settings") {
                // Navigate to settings screen (if needed)
              } else if (value == "Logout") {
                // Perform logout operation
              }
            },
            itemBuilder: (BuildContext context) => [
              // PopupMenuItem(
              //     value: "Profile",
              //     child: Text("Profile"),
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => ProfileScreen()));
              //     }),
              PopupMenuItem(
                  value: "Settings",
                  child: const Text("Settings"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()));
                  }),
              // PopupMenuItem(
              //   value: "Logout",
              //   child: Text("Logout"),
              //   onTap: () => signout(),
              // ),
            ],
          ),
          // IconButton(
          //     onPressed: () {
          //       _loadClasses();
          //     },
          //     icon: Icon(Icons.refresh))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 90,
                child: ElevatedButton.icon(
                  label: Text(
                    "Take Attendance",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    //minimumSize: Size(300, 90),
                    elevation: 7,
                    backgroundColor: Colors.blue, // Button color
                    foregroundColor: Colors.white,
                    // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () {
                    // Action for QR Code Scanning
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanQRScreen()));
                  },
                ),
              ),
              const SizedBox(height: 15, width: 10),
              SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton.icon(
                    label:
                        Text("Add New Student", style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      //minimumSize: Size(300, 60),
                      elevation: 5,
                      backgroundColor: Colors.blue, // Button color
                      foregroundColor: Colors.white,
                      // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(Icons.school, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewStudentScreen()));

                      print("clicked");
                    }),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('users')
                      .doc(userId)
                      .collection('classes')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No classes available"));
                    }

                    var classDocs = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: classDocs.length,
                      itemBuilder: (context, index) {
                        var classData = classDocs[index];
                        String className =
                            classData['className']; // Class name as document ID

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            title: Text('Class $className',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentListScreen(
                                      classId: classData.id,
                                      className: className),
                                ),
                              );
                            },
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
