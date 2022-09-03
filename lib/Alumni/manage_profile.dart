import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'alumni_side_nav.dart';

class ManageProfile extends StatefulWidget {
  const ManageProfile({Key? key}) : super(key: key);

  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  User user = FirebaseAuth.instance.currentUser!;
  CollectionReference usersdata =
      FirebaseFirestore.instance.collection('Users');

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController organization = TextEditingController();
  TextEditingController expertise = TextEditingController();
  TextEditingController dob = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  String profilePicLink = "";
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dob.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  XFile? _image;

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );
    User user = FirebaseAuth.instance.currentUser!;
    Reference ref =
        FirebaseStorage.instance.ref().child(user.uid + "profilepic.jpg");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Profile'),
        backgroundColor: Color(0xFF800000),
      ),
      drawer: const NavBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(8.0),
          child: Center(
              child: Column(children: [
            const SizedBox(height: 8),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('AlumniDetails')
                  .doc(user.uid)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  var output = snapshot.data!.data()!;
                  name.text = output['name'];
                  email.text = output['email'];
                  organization.text = output['organization'];
                  expertise.text = output['expertise'];
                  Timestamp t =
                      Timestamp.fromDate(DateTime.parse(output['dob']));
                  DateTime d = t.toDate();
                  String displayDob = DateFormat('yyyy-MM-dd').format(d);
                  dob.text = displayDob;
                  String photoUrl = output['photoUrl'];
                  return Column(children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          pickUploadProfilePic();
                        },
                        child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xffFDCF09),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: (_image != null)
                                  ? Image.file(
                                      File(_image!.path),
                                    )
                                  : Image.network(
                                      photoUrl,
                                    ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      controller: email,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'DOB',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      onTap: () => _selectDate(context),
                      readOnly: true,
                      controller: dob,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Organization',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      controller: organization,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Expertise',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      controller: expertise,
                    )
                  ]);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(
              height: 18,
            ),
            ElevatedButton(
                onPressed: () {
                  CollectionReference details =
                      FirebaseFirestore.instance.collection('AlumniDetails');
                  Future<void> addDetails() {
                    // Call the user's CollectionReference to add a new user
                    return details
                        .doc(user.uid)
                        .update({
                          "name": name.text,
                          "email": email.text,
                          "dob": dob.text,
                          "photoUrl": profilePicLink,
                          "organization": organization.text,
                          "expertise": expertise.text,
                        })
                        .then((value) => print("Profile Updated"))
                        .catchError(
                            (error) => print("Failed to add Review: $error"));
                  }

                  addDetails();
                },
                child: const Text('Update')),
          ])),
        ),
      ),
    );
  }
}
