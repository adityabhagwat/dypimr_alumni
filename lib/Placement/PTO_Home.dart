import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypimr_alumni/Provider/email_Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PTOHome extends StatefulWidget {
  const PTOHome({Key? key}) : super(key: key);

  @override
  State<PTOHome> createState() => _PTOHomeState();
}

class _PTOHomeState extends State<PTOHome> {
  @override
  Widget build(BuildContext context) {
    var _firebaseFirestore =
        FirebaseFirestore.instance.collection('Alumni_Details');
    User user = FirebaseAuth.instance.currentUser!;
    String uid = user.uid;
    String approvedProfileStatus = "";

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Placement officer'),
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
