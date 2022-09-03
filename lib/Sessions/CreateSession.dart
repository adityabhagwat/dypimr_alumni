import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypimr_alumni/Sessions/Sessions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateSession extends StatefulWidget {
  const CreateSession({Key? key}) : super(key: key);

  @override
  State<CreateSession> createState() => _CreateSessionState();
}

class _CreateSessionState extends State<CreateSession> {
  User user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  TextEditingController sessionNameController = TextEditingController();
  TextEditingController sessionSubjectController = TextEditingController();
  TextEditingController sessionDateController = TextEditingController();
  TextEditingController sessionLinkController = TextEditingController();
  TextEditingController sessionStartController = TextEditingController();
  TextEditingController sessionEndController = TextEditingController();
  TextEditingController sessionTakerController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        sessionDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
        sessionStartController.text = selectedStartTime.format(context);
      });
    } else {
      setState(() {
        sessionStartController.text = selectedStartTime.format(context);
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
        sessionEndController.text = selectedEndTime.format(context);
      });
    } else {
      setState(() {
        sessionEndController.text = selectedEndTime.format(context);
      });
    }
  }

  void clearText() {
    sessionLinkController.clear();
    sessionDateController.clear();
    sessionSubjectController.clear();
    sessionNameController.clear();
    sessionEndController.clear();
    sessionStartController.clear();
    sessionTakerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Sessions'),
        elevation: 0,
        backgroundColor: Color(0xFF800000),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Cannot be empty' : null,
                          controller: sessionNameController,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'Session Name',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Cannot be empty' : null,
                          controller: sessionSubjectController,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'Subject',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter Link' : null,
                          controller: sessionLinkController,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'Link to session',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) => val!.isEmpty
                              ? 'Enter Session Conductor Name'
                              : null,
                          controller: sessionTakerController,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'Session Conductor Name',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter Date of Session' : null,
                          controller: sessionDateController,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'Date Of Session',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter Start time' : null,
                          controller: sessionStartController,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () => _selectStartTime(context),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'Start time',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter End Time' : null,
                          controller: sessionEndController,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () => _selectEndTime(context),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'End Time',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF800000),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    CollectionReference events =
                                        FirebaseFirestore.instance
                                            .collection('Events');
                                    Future<void> addJob() {
                                      // Call the user's CollectionReference to add a new user
                                      return events
                                          .add({
                                            "Session Name":
                                                sessionNameController.text,
                                            "Session Subject":
                                                sessionSubjectController.text,
                                            "Session Date":
                                                sessionDateController.text,
                                            "Session Link":
                                                sessionLinkController.text,
                                            "Start Time":
                                                sessionStartController.text,
                                            "End Time":
                                                sessionEndController.text,
                                            "Session Conductor":
                                                sessionTakerController.text,
                                          })
                                          .then((value) => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: const Text(
                                                      'DYPIMR ALUMNIS',
                                                      style: TextStyle(
                                                        color: Colors.lightBlue,
                                                      ),
                                                    ),
                                                    content: const Text(
                                                      'Event added',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                          onPressed: () {
                                                            clearText();
                                                            Navigator.pop(context);
                                                          },
                                                          child:
                                                              const Text('OK')),
                                                    ],
                                                  )))
                                          .catchError((e) => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: const Text(
                                                      'DYPIMR ALUMNIS',
                                                      style: TextStyle(
                                                        color: Colors.lightBlue,
                                                      ),
                                                    ),
                                                    content: Text(
                                                      'Event Not Added \n $e',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text('OK')),
                                                    ],
                                                  )));
                                    }

                                    addJob();
                                  }
                                },
                                child: Text(
                                  'Create',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
