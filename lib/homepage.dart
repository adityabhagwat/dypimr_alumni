import 'package:dypimr_alumni/UserHome.dart';
import 'package:dypimr_alumni/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (snapshot.hasError) {
            return Center(
              child: Text('Something Went Wrong'),
            );
          } else if (snapshot.hasData) {
            return UserHome();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
