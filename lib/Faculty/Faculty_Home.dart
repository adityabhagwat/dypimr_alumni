import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypimr_alumni/Provider/email_Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacultyHome extends StatefulWidget {
  const FacultyHome({Key? key}) : super(key: key);

  @override
  State<FacultyHome> createState() => _FacultyHomeState();
}

class _FacultyHomeState extends State<FacultyHome> {
  @override
  Widget build(BuildContext context) {
    var _firebaseFirestore =
        FirebaseFirestore.instance.collection('Alumni_Details');
    User user = FirebaseAuth.instance.currentUser!;
    String uid = user.uid;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Faculty'),
            ElevatedButton(
                onPressed: () {
                  final provider = Provider.of<AuthenticationService>(context,
                      listen: false);
                  provider.signOut();
                  context.read<AuthenticationService>().signOut();
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
