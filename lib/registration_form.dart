import 'dart:ui';

import 'package:dypimr_alumni/Provider/email_Authentication.dart';
import 'package:dypimr_alumni/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Registration_Form extends StatefulWidget {
  const Registration_Form({Key? key}) : super(key: key);

  @override
  _Registration_FormState createState() => _Registration_FormState();
}

class _Registration_FormState extends State<Registration_Form> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController passingYearController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String user = 'Admin';
  String branch = 'MBA';
  String gender = 'Male';
  String userType = 'Alumni';
  String approvedProfileStatus = 'Not Approved Yet';
  var batch = "1996-1999";
  var users = ['Admin', 'Alumni', 'Faculty', 'Placement Officer'];
  var branches = ['MBA', 'MCA'];
  var genders = ['Male', 'Female', 'Other'];
  var batches = [
    "1996-1999",
    "1997-2000",
    "1998-2001",
    "1999-2002",
    "2000-2003",
    "2001-2004",
    "2002-2005",
    "2003-2006",
    "2004-2007",
    "2005-2008",
    "2006-2009",
    "2007-2010",
    "2008-2011",
    "2009-2012",
    "2010-2013",
    "2011-2014",
    "2012-2015",
    "2013-2016",
    "2014-2017",
    "2015-2018",
    "2016-2019",
    "2017-2020",
    "2018-2021",
  ];

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
        dobController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni Registration'),
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
              //title of page
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
                              val!.isEmpty ? 'Enter Name' : null,
                          controller: nameController,
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
                            labelText: 'Name',
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
                              val!.isEmpty ? 'Enter an email' : null,
                          controller: emailController,
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
                            labelText: 'Email',
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          validator: (val) => val!.isEmpty ? 'Enter DOB' : null,
                          controller: dobController,
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
                            labelText: 'Date Of Birth',
                            icon: Icon(
                              Icons.calendar_month,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: DropdownButtonFormField(
                          items: genders.map((String gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              gender = newValue!;
                            });
                          },
                          value: gender,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'Select Gender',
                            icon: Icon(
                              Icons.face_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: DropdownButtonFormField(
                          items: branches.map((String branch) {
                            return DropdownMenuItem(
                              value: branch,
                              child: Text(branch),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              branch = newValue!;
                            });
                          },
                          value: branch,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'Select Branch',
                            icon: Icon(
                              Icons.cases_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ), //namefield

                      Container(
                        padding: EdgeInsets.all(5),
                        child: DropdownButtonFormField(
                          items: batches.map((String batch) {
                            return DropdownMenuItem(
                              value: batch,
                              child: Text(batch),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              batch = newValue!;
                            });
                          },
                          value: batch,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'Select Batch',
                            icon: Icon(
                              Icons.perm_contact_cal_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      //emailfield
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          validator: (val) => val!.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          controller: passwordController,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'Password',
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ), //passwordfield
                    ],
                  ),
                ),
              ), //textfields

              const SizedBox(
                height: 5,
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

                      dynamic result = await context
                          .read<AuthenticationService>()
                          .signUp(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              nameController.text.trim(),
                              dobController.text.trim(),
                              gender,
                              branch,
                              batch,
                              approvedProfileStatus,
                              userType);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Could not Register with those credentials';
                        });
                      } else {
                        await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                    'DYPIMR ALUMNI',
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                  content: const Text(
                                    'You Are Registered to DYPIMR ALUMNI \n Happy Journey with Us !',
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

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: const Text(
                    'Already Registered? Click here to Sign In',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  )),
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
