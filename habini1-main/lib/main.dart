import 'package:flutter/material.dart';
import 'package:habini/screens/save_user_data.dart';
import 'package:habini/screens/sign_up_screen.dart';
import 'package:habini/screens/welcome_screen.dart';
import 'package:habini/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:habini/screens/home_screen.dart';
import 'package:habini/screens/sign_in_phone_screen.dart';
import 'package:habini/screens/navigation_page.dart';
import 'package:habini/screens/university_number_auth_screen.dart';
import 'package:habini/screens/comments_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(habini());
}

class habini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      initialRoute: 'navigation_page',
      routes: {
        'save_user_data': (context) => SaveUserData(),
        'welcome_screen': (context) => WelcomeScreen(),
        'navigation_page': (context) => MyBottomNavigationBar(),
        'sign_in_screen': (context) => SignIn(),
        'sign_up_screen': (context) => SignUp(),
        'home_screen': (context) => HomeIndex(),
        'comments_screen': (context) => CommentsScreen(),
        'university_number_auth_screen': (context) => UniversityAuth(),
      },
    );
  }
}
