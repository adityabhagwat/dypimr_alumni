import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddJobsList extends StatefulWidget {
  const AddJobsList({Key? key}) : super(key: key);

  @override
  _AddJobsListState createState() => _AddJobsListState();
}

class _AddJobsListState extends State<AddJobsList> {
  String? companyName, designation, link, description, refDetails;
  final DateTime date = DateTime.now();
  DateTime selectedDate = DateTime.now();
  TextEditingController lastDate = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        lastDate.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Jobs'),
        backgroundColor: Color(0xFF800000),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Company Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onChanged: (value) {
                  companyName = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Designation',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onChanged: (value) {
                  designation = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Referral Details',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onChanged: (value) {
                  refDetails = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  labelText: 'Last Date',
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                controller: lastDate,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Job Link',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onChanged: (value) {
                  link = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter Job Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onChanged: (value) {
                  description = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    CollectionReference jobs =
                        FirebaseFirestore.instance.collection('joblist');
                    Future<void> addJob() {
                      // Call the user's CollectionReference to add a new user
                      return jobs
                          .add({
                            "Company Name": companyName,
                            "Designation": designation,
                            "refDetails": refDetails,
                            "description": description,
                            "job_link": link,
                            "date": date.toString(),
                            "lastdate": lastDate.text.trim(),
                          })
                          .then((value) => print("Job Added"))
                          .catchError(
                              (error) => print("Failed to add Review: $error"));
                    }

                    await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                'DYPIMR ALUMNIS',
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                ),
                              ),
                              content: const Text(
                                'Thank You!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      return Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('OK')),
                              ],
                            ));
                    addJob();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add Job',
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
