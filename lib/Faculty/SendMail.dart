import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SendMail extends StatefulWidget {
  const SendMail({required this.data});

  final QueryDocumentSnapshot<Object?> data;

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  TextEditingController receiverEmailController = TextEditingController();
  TextEditingController senderEmailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController emailBodyController = TextEditingController();

  Future<void> send() async {
    final Email email = Email(
      body: emailBodyController.text,
      subject: subjectController.text,
      recipients: [receiverEmailController.text, senderEmailController.text],
    );
    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _firebaseFirestore = FirebaseFirestore.instance.collection('Users');
    User user = FirebaseAuth.instance.currentUser!;
    String uid = user.uid;

    senderEmailController.text = user.email.toString();
    receiverEmailController.text = widget.data['email'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Invitation'),
        elevation: 0,
        backgroundColor: Color(0xFF800000),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: const Text(
                  'Send Invitation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ), //title of page
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  margin: EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter Alumni Email' : null,
                          controller: receiverEmailController,
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
                            labelText: 'Alumni Email',
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter sender email' : null,
                          controller: senderEmailController,
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
                            labelText: 'From',
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ), //namefield

                      Container(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          validator: (val) =>
                              val!.length < 6 ? 'Enter Subject' : null,
                          controller: subjectController,
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
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          maxLines: 10,
                          validator: (val) =>
                              val!.length < 6 ? 'Enter Email Body' : null,
                          controller: emailBodyController,
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
                            labelText: 'Body',
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            hintMaxLines: 10,
                          ),
                        ),
                      ), //passwordfield
                    ],
                  ),
                ),
              ), //textfields

              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    shadowColor: Colors.black,
                    primary: Color(0xFF800000),
                    fixedSize: Size(150, 50),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                    }

                    send();
                  },
                  child: const Text(
                    'Send Invitation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
              SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 10,
              ), //signinbutton
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ), //signinwithgoogle
            ],
          ),
        ),
      ),
    );
  }
}
