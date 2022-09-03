import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypimr_alumni/Sessions/CreateSession.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Sessions extends StatefulWidget {
  const Sessions({Key? key}) : super(key: key);

  @override
  State<Sessions> createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  @override
  Widget build(BuildContext context) {
    final _firebaseFirestore = FirebaseFirestore.instance.collection('Events');
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni Sessions'),
        elevation: 0,
        backgroundColor: Color(0xFF800000),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchSessions(),
                );
              },
              icon: Icon(Icons.search)),
        ],
      ),
      bottomSheet: ListTile(
        title: Text(
          'DPU ©',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        tileColor: Color(0xFF800000),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF800000),
        tooltip: 'Create Session',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateSession()));
        },
        child: Icon(Icons.add),
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
                    final String? sessionName = data['Session Name'];
                    final String? sessionSubject = data['Session Subject'];
                    final String? sessionLink = data['Session Link'];
                    final String? sessionDate = data['Session Date'];
                    final String? sessionConductor = data['Session Conductor'];
                    final String? startTime = data['Start Time'];
                    final String? endTime = data['End Time'];

                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Subject",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Conductor",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Start",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "End",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ": " + sessionName!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    ": " + sessionSubject!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    ": " + sessionConductor!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    ": " + sessionDate!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    ": " + startTime!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    ": " + endTime!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ]),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      if (await canLaunchUrlString(
                                          sessionLink!)) {
                                        launchUrlString(sessionLink!);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF800000),
                                    ),
                                    child: Text('Join Session')),
                              ],
                            )
                          ],
                        ),
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

class SearchSessions extends SearchDelegate {
  final _firebaseFirestore = FirebaseFirestore.instance.collection('Events');

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
                    element['Session Subject']
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
                          element['Session Subject']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    String uid = data.id;
                    final String? sessionName = data['Session Name'];
                    final String? sessionSubject = data['Session Subject'];
                    final String? sessionLink = data['Session Link'];
                    final String? sessionDate = data['Session Date'];
                    final String? sessionConductor = data['Session Conductor'];
                    final String? startTime = data['Start Time'];
                    final String? endTime = data['End Time'];

                    return Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text("Name"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(sessionName!)
                                ],
                              )
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
