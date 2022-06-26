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
  String approvedProfileStatus = 'Not Approved Yet';
  var passingYear = 1996;
  var users = ['Admin', 'Alumni', 'Faculty', 'Placement Officer'];
  var branches = ['MBA', 'MCA'];
  var genders = ['Male', 'Female', 'Other'];
  var passingYears = [
    1996,
    1997,
    1998,
    1999,
    2000,
    2001,
    2002,
    2003,
    2004,
    2005,
    2006,
    2007,
    2008,
    2009,
    2010,
    2011,
    2012,
    2013,
    2014,
    2015,
    2016,
    2018,
    2019,
    2020
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
        title: Text('Registration'),
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
                  'Alumni Registration',
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
                          items: passingYears.map((int passingYear) {
                            return DropdownMenuItem(
                              value: passingYear,
                              child: Text(passingYear.toString()),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              passingYear = newValue!;
                            });
                          },
                          value: passingYear,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            labelText: 'Select Passing Year',
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

                      dynamic result = await context
                          .read<AuthenticationService>()
                          .signUp(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              nameController.text.trim(),
                              dobController.text.trim(),
                              gender,
                              branch,
                              passingYear,
                              approvedProfileStatus);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Could not sign in with those credentials';
                        });
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
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: const Text(
                    'Already Registered? Click here to Sign In',
                    style: TextStyle(
                      fontSize: 20,
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
