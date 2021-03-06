import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habini/components.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habini/screens/welcome_screen.dart';

class UniversityAuth extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<UniversityAuth> {
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
                        'Are you student ?',
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
                            labelText: 'University ID',
                            icon: Icon(
                              Icons.account_circle,
                              color: Colors.blue,
                            ),
                            keyBordType: null,
                            hidden: false,
                            inputFormatters: null,
                            onChange: (value) {},
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        KmaterialButton(
                          label: 'Check',
                          onPressed: () {
                            Navigator.pushNamed(context, 'sign_up_screen');
                          },
                          color: Colors.blue[800],
                        ),
                        Column(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'welcome_screen',
                                    (Route<dynamic> route) => false);
                              },
                              child: Text(
                                'Already Signed Up',
                                style: TextStyle(
                                  color: Colors.blue[800],
                                ),
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
