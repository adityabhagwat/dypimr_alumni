import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypimr_alumni/Faculty/faculty_side_nav.dart';
import 'package:dypimr_alumni/util/NotificationApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlumniBirthdays extends StatefulWidget {
  const AlumniBirthdays({Key? key}) : super(key: key);

  @override
  State<AlumniBirthdays> createState() => _AlumniBirthdaysState();
}

class _AlumniBirthdaysState extends State<AlumniBirthdays> {
  @override
  @override
  Widget build(BuildContext context) {
    var temp = DateTime.now();
    var currentDate = DateTime.utc(temp.month, temp.day);
    final _firebaseFirestore =
        FirebaseFirestore.instance.collection('AlumniDetails');
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Alumnni Details'),
        backgroundColor: Color(0xFF800000),
      ),
      bottomSheet: ListTile(
        title: Text(
          'DPU ©',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        tileColor: Color(0xFF800000),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .map((QueryDocumentSnapshot<Object?> data) {
                    String uid = data.id;
                    final String? Name = data['name'];
                    final String? Email = data['email'];
                    Timestamp t = data['dob'];
                    DateTime date = t.toDate();
                    String dob = DateFormat('yyyy-MM-dd').format(date);
                    final dateOfBirth = date;
                    if (currentDate ==
                        DateTime.utc(dateOfBirth.month, dateOfBirth.day)) {
                      NotificationApi.showNotifications(
                        title: "Birthday & Annivarsaries",
                        body: "Hey, Its " +
                            Name! +
                            "'s Birthday today. Wish them a Happy Birthday",
                      );
                      return Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            ListTile(
                              title: RichText(
                                  text: TextSpan(
                                children: [
                                  const TextSpan(
                                      text: "Name : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                      )),
                                  TextSpan(
                                    text: '$Name',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.red,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const TextSpan(text: "\n"),
                                  const TextSpan(
                                      text: "Email : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                      )),
                                  TextSpan(
                                    text: '$Email',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.blue,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const TextSpan(text: "\n"),
                                  const TextSpan(
                                      text: "DOB: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                      )),
                                  TextSpan(
                                    text: '$dob',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const TextSpan(text: "\n"),
                                ],
                              )),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Card(
                        elevation: 0,
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'No Birthdays today',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  })
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
