import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import fluttertoast package
import 'package:flutter_front/screens/signin_screen.dart';
import 'package:flutter_front/themes/theme.dart';
import 'package:flutter_front/widgets/custom_scaffold.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; // Import intl_phone_field package
import 'package:csc_picker/csc_picker.dart';
//import 'package:flutter_front/screens/routes.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
  
}



enum UserType { professional, client }

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = true;
  String _password = ''; // Variable to store the password
  String _confirmPassword = ''; // Variable to store the confirmed password
  bool _obscureText = true; // Variable to toggle password visibility
  int? role;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String firstname = "";
  String lastname = "";
  String email ="";
  String phone="";
  String? profession;
  String address="";
  Map<String, dynamic> constructFormData() {
    return {
      'email': email,
      'password': _password,
      'role': role,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'profession': profession,
      'address': address,
      'city': cityValue,
      'country': countryValue,
      'state': stateValue,
    };
  }
  Future<void> signUp() async {
  final url = Uri.parse('http://localhost:5032/api/Auth/register');
  final headers = {'Content-Type': 'application/json'};

  final body = jsonEncode(constructFormData());
  final response = await http.post(url,headers: headers, body: body);

  if (response.statusCode == 200) {
  print('Registration successful: ${response.body}');
   // Clear form fields after successful registration
    _formSignupKey.currentState!.reset();
    email = '';
    _password = '';
    _confirmPassword = '';
    role = null;
    firstname = '';
    lastname = '';
    phone = '';
    profession = null;
    address = '';
    cityValue = '';
    countryValue = '';
    stateValue = '';
  } else {
    print('Registration failed: ${response.body}');
    throw Exception('Failed to register');
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
                // get started form
                child: Form(
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // get started text
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      // first name
                      TextFormField(
                         onChanged: (value) {
                          setState(() {
                         firstname = value;
                         });
                         },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter first name';
                          } else if (!_isValidName(value)) {
                            return 'First name can only contain letters and spaces';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('First Name'),
                          hintText: 'Enter First Name',
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
                      // last name
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                         lastname = value;
                         });
                         },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          } else if (!_isValidName(value)) {
                            return 'Last name can only contain letters and spaces';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Last Name'),
                          hintText: 'Enter Last Name',
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
                      // email
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                         email = value;
                         });
                         },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          } else if (!_isValidEmail(value)) {
                            return 'Please enter a valid email';
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
                      Row(
                        children: [
                          // CSC Picker Widget
                          Expanded(
                            
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Adding CSC Picker Widget in app
                                  CSCPicker(
                                    showStates: true,
                                    showCities: true,
                                    flagState: CountryFlag.DISABLE,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey.shade300, width: 1),
                                    ),
                                    disabledDropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.grey.shade300,
                                      border: Border.all(color: Colors.grey.shade300, width: 1),
                                    ),
                                    countrySearchPlaceholder: "Country",
                                    stateSearchPlaceholder: "State",
                                    citySearchPlaceholder: "City",
                                    countryDropdownLabel: "*Country",
                                    stateDropdownLabel: "*State",
                                    cityDropdownLabel: "*City",
                                    selectedItemStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    dropdownHeadingStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    dropdownItemStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    dropdownDialogRadius: 10.0,
                                    searchBarRadius: 10.0,
                                    onCountryChanged: (value) {
                                      setState(() {
                                        countryValue = value;
                                      });
                                    },
                                    onStateChanged: (String? value) {
                                      setState(() {
                                        stateValue = value ?? ''; // Assigning selected state value
                                      });
                                    },
                                    onCityChanged: (String? value) {
                                      setState(() {
                                        cityValue = value ?? ''; // Assigning selected city value
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // Phone number
                      Row(
                        children: [
                          // Phone number field
                          Expanded(
                            child: IntlPhoneField(
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                hintText: 'Enter Phone Number',
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
                              initialCountryCode: 'US',
                              onChanged: (value) {
                                phone=value.completeNumber;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // password
                      TextFormField(
                        obscureText: _obscureText,
                        onChanged: (value) {
                          _password = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          } else if (!_isValidPassword(value)) {
                            _showToast('Password must contain at least one uppercase, one lowercase, one symbol, and one digit');
                            return 'Invalid password';
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
                              // Toggle password visibility
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
                      // confirmation password
                      TextFormField(
                        obscureText: _obscureText,
                        onChanged: (value) {
                          _confirmPassword = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Confirm Password';
                          } else if (value != _password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Confirm Password'),
                          hintText: 'Confirm Password',
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
                      // i am a
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'I am a:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              // Professional radio button
                              Radio(
                                value: 0,
                                groupValue: role,
                                onChanged: (int? value) {
                                  setState(() {
                                    role = value;
                                  });
                                },
                              ),
                              Text('Professional'),

                              // Client radio button
                              Radio(
                                value: 1,
                                groupValue: role,
                                onChanged: (int? value) {
                                  setState(() {
                                    role = value;
                                  });
                                },
                              ),
                              Text('Client'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // Choose a profession
                      if (role == 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Choose a profession:',
                              style: TextStyle(fontSize: 16),
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'Plumber',
                                  child: Text('Plumber'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Electrician',
                                  child: Text('Electrician'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Gardener',
                                  child: Text('Gardener'),
                                ),
                                // Add more professions here
                              ],
                              onChanged: (String? value) {
                                profession=value;
                              },
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            // Address
                            TextFormField(
                              onChanged: (value) {
                          setState(() {
                         address = value;
                         });
                         },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('Address'),
                                hintText: 'Enter Address',
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
                          
                          ],
                        ),
                      // i agree to the processing
                      Row(
                        children: [
                          Checkbox(
                            value: agreePersonalData,
                            onChanged: (bool? value) {
                              setState(() {
                                agreePersonalData = value!;
                              });
                            },
                            activeColor: lightColorScheme.primary,
                          ),
                          const Text(
                            'I agree to the processing of ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          Text(
                            'Personal data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: lightColorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // signup button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                       onPressed: () {
                        if (_formSignupKey.currentState!.validate() &&
                          agreePersonalData &&
                          _password == _confirmPassword) {
                         _showToast('Welcome! Please login');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInScreen()),
                              );
                            signUp(); 
                            } else if (!agreePersonalData) {
                             _showToast('Please agree to the processing of personal data');
                           } else if (_password != _confirmPassword) {
                            _showToast('Passwords do not match');
                           }
                        },
                          child: const Text('Sign up'),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      // sign up divider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                            child: Text(
                              'Sign up with',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      // sign up social media logo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.facebook),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.email),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.apple),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // already have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const SignInScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign in',
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

  // Function to validate email format
  bool _isValidEmail(String value) {
    // Regular expression for email validation
    final emailRegExp =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(value);
  }

  // Function to validate name
  bool _isValidName(String value) {
    // Regular expression for name validation
    final nameRegExp = RegExp(r'^[a-zA-Z\séàè]+$');
    return nameRegExp.hasMatch(value);
  }

  // Function to validate password requirements
  bool _isValidPassword(String value) {
    // Regular expression for password validation
    final passwordRegExp =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegExp.hasMatch(value);
  }

  // Function to show toast
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  

  
}
