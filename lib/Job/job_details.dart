import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({required this.data});

  final QueryDocumentSnapshot<Object?> data;

  @override
  _JobDetailsPageState createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  DateTime? date;
  var d12;

  @override
  Widget build(BuildContext context) {
    DateTime d = DateTime.parse(widget.data['date']);
    String addedDate = DateFormat('yyyy-MM-dd').format(d);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        backgroundColor: Color(0xFF800000),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Card(
              margin: EdgeInsets.all(5.0),
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Company Name :  " + widget.data['Company Name']),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Designation  :  " + widget.data['Designation']),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Referral Details  :  " + widget.data['refDetails']),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Added on Date:  " + addedDate),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Last Date to Apply:  " + widget.data['lastdate']),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Description  :  " + widget.data['description']),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () async {
                          if (await canLaunchUrlString(
                              widget.data['job_link'])) {
                            launchUrlString(widget.data['job_link']);
                          }
                        },
                        child: const Text('Apply Here')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
