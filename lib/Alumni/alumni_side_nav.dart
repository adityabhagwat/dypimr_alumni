import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypimr_alumni/Alumni/Alumni_Home.dart';
import 'package:dypimr_alumni/Alumni/company_profile.dart';
import 'package:dypimr_alumni/Alumni/jobs.dart';
import 'package:dypimr_alumni/Alumni/manage_profile.dart';
import 'package:dypimr_alumni/Provider/email_Authentication.dart';
import 'package:dypimr_alumni/Sessions/Sessions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('Users');
    User user = FirebaseAuth.instance.currentUser!;
    String uid = user.uid;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: collection.doc(uid).snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  var output = snapshot.data!.data();
                  var value = output!['name']; // <-- Your value
                  return Text('$value', style: TextStyle(color: Colors.black));
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
            accountEmail: Text(
              user.email!,
              style: TextStyle(color: Colors.black),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/DPUlogo.png'),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AlumniHome()));
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Manage Account'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ManageProfile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt_1),
            title: Text('Events & Sessions'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Sessions()));
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text('Company Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CompanyProfile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text('Job Openings'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => JobsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock_open_outlined),
            title: Text('Log Out'),
            onTap: () {
              final provider =
                  Provider.of<AuthenticationService>(context, listen: false);
              provider.signOut();
              context.read<AuthenticationService>().signOut();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share App'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
