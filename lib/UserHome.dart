import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypimr_alumni/Admin/Admin_Home.dart';
import 'package:dypimr_alumni/Alumni/Alumni_Home.dart';
import 'package:dypimr_alumni/Faculty/Faculty_Home.dart';
import 'package:dypimr_alumni/Placement/PTO_Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    var _firebaseFirestore = FirebaseFirestore.instance.collection('Users');
    User user = FirebaseAuth.instance.currentUser!;
    String uid = user.uid;
    String userType = "";

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _firebaseFirestore.doc(uid).snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');
        if (snapshot.hasData) {
          var output = snapshot.data!.data();
          userType = output!['userType'];
          if (userType == 'Admin') {
            return AdminHome();
          } else if (userType == 'Alumni') {
            return AlumniHome();
          } else if (userType == 'Faculty') {
            return FacultyHome();
          } else {
            return PTOHome(); // <-- Your value
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
