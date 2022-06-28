import 'package:dypimr_alumni/Provider/email_Authentication.dart';
import 'package:dypimr_alumni/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  TextEditingController emailController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DYPIMR ALUMNIs'),
        backgroundColor: Color(0xFF800000),
      ),
      body: Center(
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
                'Forgot Password',
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
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        labelText: 'Email',
                        icon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 20,
                        shadowColor: Colors.black,
                        primary: Color(0xFF800000),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);

                          dynamic result = await context
                              .read<AuthenticationService>()
                              .forgotPassword(
                                emailController.text.trim(),
                              );
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error =
                                  'Could not send sign in link to those credentials';
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
                                        'Password Reset Link has been sent to your Registered Mail ID, Please Check Spam',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              return Navigator.pop(
                                                  context, 'OK');
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
                        'Send Password Reset Link',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
