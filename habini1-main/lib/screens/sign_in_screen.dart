import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habini/components.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;
  var email;
  var password;
  bool showSinner = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[900],
        body: ModalProgressHUD(
          inAsyncCall: showSinner,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(3.0),
                      child: Text(
                        '5abini App',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: KTextField(
                            labelText: 'PhoneNumber',
                            icon: Icon(
                              Icons.phone,
                              color: Colors.blue,
                            ),
                            keyBordType: null,
                            hidden: false,
                            inputFormatters: null,
                            onChange: (value) {
                              email = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: KTextField(
                            labelText: 'Password',
                            keyBordType: null,
                            inputFormatters: null,
                            hidden: true,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
                            onChange: (value) {
                              password = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        KmaterialButton(
                          label: 'Log In',
                          onPressed: () async {
                            try {
                              setState(() {
                                showSinner = true;
                              });
                              final loginUser =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              if (loginUser != null) {
                                setState(() {
                                  showSinner = false;
                                });
                                Navigator.pushNamed(context, 'navigation_page');
                              }
                            } catch (e) {
                              setState(() {
                                showSinner = false;
                              });
                              print(e);
                              Alert(
                                      context: context,
                                      title: "Warning",
                                      desc: "$e")
                                  .show();
                            }
                          },
                          color: Colors.blue[800],
                        ),
                        Column(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'sign_up_screen');
                              },
                              child: Text(
                                'sign up ',
                                style: TextStyle(
                                  color: Colors.blue[800],
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Recover password',
                                style: TextStyle(color: Colors.blue[900]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
