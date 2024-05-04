import 'package:flutter/material.dart';
import 'package:flutter_front/screens/ClientWorkRequestsPage.dart';
import 'package:flutter_front/screens/client_home.dart';
import 'package:flutter_front/screens/prof_home.dart';
//import 'package:flutter_front/screens/routes.dart'; 
import 'package:flutter_front/screens/signin_screen.dart';
import 'package:flutter_front/screens/signup_screen.dart';
import 'package:flutter_front/themes/theme.dart';
import 'package:flutter_front/screens/welcome_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Fix the constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      initialRoute: 'welcome_screen',
      routes: {
        'signup_screen': (context) => SignUpScreen(),
        'signin_screen ': (context) => SignInScreen(),
        '/signin': (context) => SignInScreen(),
        '/profhome': (context) => ProfHome(),

      },

      home: ClientWorkRequestPage(),
    );
  }
}
