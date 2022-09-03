import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypimr_alumni/Admin/admin_side_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManageAlumnis extends StatefulWidget {
  const ManageAlumnis({Key? key}) : super(key: key);

  @override
  State<ManageAlumnis> createState() => _ManageAlumnisState();
}

class _ManageAlumnisState extends State<ManageAlumnis> {
  final _firebaseFirestore = FirebaseFirestore.instance
      .collection('Users')
      .where('userType', isEqualTo: 'Alumni');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Manage Alumnni'),
        backgroundColor: Color(0xFF800000),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchAlumni(),
                );
              },
              icon: Icon(Icons.search)),
        ],
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
                    DateTime d = t.toDate();
                    String dob = DateFormat('yyyy-MM-dd').format(d);
                    final String? gender = data['gender'];
                    final String? branch = data['branch'];
                    final String? passingYear = data['batch'];
                    String? approvedProfileStatus =
                        data['approvedProfileStatus'];

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
                                const TextSpan(
                                    text: "Gender : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                  text: '$gender',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                const TextSpan(text: "\n"),
                                const TextSpan(
                                    text: "Branch: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                  text: '$branch',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                const TextSpan(text: "\n"),
                                const TextSpan(
                                    text: "Passing Year : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                  text: '$passingYear',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                                const TextSpan(text: "\n"),
                                const TextSpan(
                                    text: "Status : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                  text: '$approvedProfileStatus',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      var collection = FirebaseFirestore
                                          .instance
                                          .collection("Users")
                                          .doc(uid)
                                          .delete();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text('Delete')
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    var collection = FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(uid)
                                        .update({
                                      'approvedProfileStatus': 'Approved'
                                    });

                                    var collection2 = FirebaseFirestore.instance
                                        .collection("AlumniDetails")
                                        .doc(uid)
                                        .set({
                                      "name": Name,
                                      "email": Email,
                                      "dob": dob,
                                      "organization": "",
                                      "expertise": "",
                                      "photoUrl": "",
                                    });
                                  },
                                  child: Text('Accept')),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    var collection = FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(uid)
                                        .update({
                                      'approvedProfileStatus': 'Not Approved'
                                    });
                                  },
                                  child: Text('Reject')),
                            ],
                          )
                        ],
                      ),
                    );
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

class SearchAlumni extends SearchDelegate {
  final _firebaseFirestore = FirebaseFirestore.instance
      .collection('Users')
      .where('userType', isEqualTo: 'Alumni');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['name']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("No search query found"),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['name']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    String uid = data.id;
                    final String? Name = data['name'];
                    final String? Email = data['email'];
                    final String? dob = data['dob'].toString();
                    final String? gender = data['gender'];
                    final String? branch = data['branch'];
                    final String? passingYear = data['passingYear'].toString();
                    String? approvedProfileStatus =
                        data['approvedProfileStatus'];

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
                                const TextSpan(
                                    text: "Gender : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                  text: '$gender',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                const TextSpan(text: "\n"),
                                const TextSpan(
                                    text: "Branch: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                  text: '$branch',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                const TextSpan(text: "\n"),
                                const TextSpan(
                                    text: "Passing Year : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                  text: '$passingYear',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                                const TextSpan(text: "\n"),
                                const TextSpan(
                                    text: "Status : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                  text: '$approvedProfileStatus',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      var collection = FirebaseFirestore
                                          .instance
                                          .collection("Users")
                                          .doc(uid)
                                          .delete();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text('Delete')
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    var collection = FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(uid)
                                        .update({
                                      'approvedProfileStatus': 'Approved'
                                    });
                                  },
                                  child: Text('Accept')),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    var collection = FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(uid)
                                        .update({
                                      'approvedProfileStatus': 'Not Approved'
                                    });
                                  },
                                  child: Text('Reject')),
                            ],
                          )
                        ],
                      ),
                    );
                  })
                ],
              );
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Search Alumni Name'));
  }
}
