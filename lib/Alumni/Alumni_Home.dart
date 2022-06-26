import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypimr_alumni/Admin/admin_side_nav.dart';
import 'package:dypimr_alumni/Provider/email_Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlumniHome extends StatefulWidget {
  const AlumniHome({Key? key}) : super(key: key);

  @override
  State<AlumniHome> createState() => _AlumniHomeState();
}

class _AlumniHomeState extends State<AlumniHome> {
  @override
  Widget build(BuildContext context) {
    var _firebaseFirestore =
        FirebaseFirestore.instance.collection('Alumni_Details');
    User user = FirebaseAuth.instance.currentUser!;
    String uid = user.uid;
    String approvedProfileStatus = "";

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _firebaseFirestore.doc(uid).snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');
        if (snapshot.hasData) {
          var output = snapshot.data!.data();
          approvedProfileStatus = output!['approvedProfileStatus'];
          if (approvedProfileStatus == 'Approved') {
            return Scaffold(
              appBar: AppBar(
                title: Text('Alumni Home'),
                elevation: 0,
                backgroundColor: Color(0xFF800000),
              ),
              drawer: NavBar(),
            );
          } else if (approvedProfileStatus == 'Not Approved Yet') {
            return Scaffold(
              appBar: AppBar(
                title: Text('Alumni Home'),
                elevation: 0,
                backgroundColor: Color(0xFF800000),
              ),
              body: Container(
                child: Column(
                  children: [
                    Text("Wait For Admin's Approval"),
                    ElevatedButton(
                        onPressed: () {
                          final provider = Provider.of<AuthenticationService>(
                              context,
                              listen: false);
                          provider.signOut();
                          context.read<AuthenticationService>().signOut();
                        },
                        child: Text('Logout'))
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Alumni Home'),
                elevation: 0,
                backgroundColor: Color(0xFF800000),
              ),
              body: Container(
                child: Column(
                  children: [
                    Text("Not Approved"),
                    ElevatedButton(
                        onPressed: () {
                          final provider = Provider.of<AuthenticationService>(
                              context,
                              listen: false);
                          provider.signOut();
                          context.read<AuthenticationService>().signOut();
                        },
                        child: Text('Logout'))
                  ],
                ),
              ),
            );
          } // <-- Your value
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
