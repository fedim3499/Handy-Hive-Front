import 'package:flutter/material.dart';
import 'package:flutter_front/screens/signin_screen.dart'; // Correct import path
import 'package:flutter_front/screens/signup_screen.dart'; // Correct import path

class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/screens/signup_screen.dart': (context) => const SignUpScreen(),
      '/screens/signin_screen.dart': (context) => const SignInScreen(),
      // Add more routes if needed
    };
  }
}
