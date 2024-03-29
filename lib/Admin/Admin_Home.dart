import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypimr_alumni/Admin/admin_side_nav.dart';
import 'package:dypimr_alumni/Provider/email_Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    var _firebaseFirestore = FirebaseFirestore.instance.collection('Users');
    User user = FirebaseAuth.instance.currentUser!;
    String uid = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
        backgroundColor: Color(0xFF800000),
      ),
      drawer: NavBar(),
      body: Center(
        child: Column(
          children: [
            Text('Admin'),
            ElevatedButton(
                onPressed: () {
                  final provider = Provider.of<AuthenticationService>(context,
                      listen: false);
                  provider.signOut();
                  context.read<AuthenticationService>().signOut();
                  Navigator.pop(context);
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
