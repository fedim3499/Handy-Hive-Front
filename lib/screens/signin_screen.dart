import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_front/screens/signup_screen.dart';
import 'package:flutter_front/themes/theme.dart';
import 'package:flutter_front/widgets/custom_scaffold.dart';
import 'package:flutter_front/screens/client_home.dart';
import 'package:flutter_front/screens/prof_home.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> _login() async {
  String email = _emailController.text;
  String password = _passwordController.text;

  var url = Uri.parse('http://localhost:5032/api/Auth/login');
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'username': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);
    print(responseData);
    String role = responseData['role'].toString();

    // Navigate based on role
    if (role == '0') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfHome()));
    } else if (role == '1') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ClientHome()));
    }
  } else {
    print(response.body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.body),
    ));
  }
}

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome back',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: 'Enter Email',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
  controller: _passwordController,
  obscureText: _obscureText,
  onChanged: (value) {
    // No need to manually manage _password, it's handled by the controller
  },
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Password';
    }
    return null;
  },
  decoration: InputDecoration(
    label: const Text('Password'),
    hintText: 'Enter Password',
    hintStyle: const TextStyle(
      color: Colors.black26,
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black12, // Default border color
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black12, // Default border color
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    suffixIcon: IconButton(
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      icon: Icon(
        _obscureText ? Icons.visibility : Icons.visibility_off,
        color: Colors.black,
      ),
    ),
  ),
),

                      const SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _login,
                          child: const Text('Sign in'),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
