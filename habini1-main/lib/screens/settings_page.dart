import 'package:flutter/material.dart';
import 'package:habini/screens/welcome_screen.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Row(
            children: [
              Icon(
                Icons.settings,
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ],
          )),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: 'Change Profile Picture',
                leading: Icon(Icons.account_circle),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Change Password',
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Change Location',
                leading: Icon(Icons.add_location_alt),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Dark mode',
                leading: Icon(Icons.nights_stay),
                switchValue: false,
                onToggle: (bool value) {},
              ),
              SettingsTile(
                title: 'Delete Account',
                leading: Icon(Icons.block_flipped),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Sign out',
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.redAccent,
                ),
                onPressed: (BuildContext context) async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ),
                      (route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
