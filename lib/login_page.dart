import 'dart:ui';

import 'package:dypimr_alumni/Provider/email_Authentication.dart';
import 'package:dypimr_alumni/forgotPassword.dart';
import 'package:dypimr_alumni/registration_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String user = 'Admin';

  var users = ['Admin', 'Alumni', 'Faculty', 'Placement Officer'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
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
                  'WELCOME',
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
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          controller: emailController,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
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
                      ), //emailfield
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (val) => val!.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          controller: passwordController,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
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
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: const Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
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
                      var result =
                          await context.read<AuthenticationService>().signIn(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                      if (result == null) {
                        Scaffold.maybeOf(context)?.showSnackBar(
                          SnackBar(content: Text('Invalid Credentials')),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Sign in',
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registration_Form()));
                  },
                  child: const Text(
                    'New User? Click Here to Register',
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
