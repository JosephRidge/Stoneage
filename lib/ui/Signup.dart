import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stoneage/ui/Home.dart';
import 'package:stoneage/data/globals.dart' as globals;

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:stoneage/ui/Login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool showProgress = false;
  bool authenticated = false;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // create/{username}

    Future<Map<String,dynamic>> createUser(username) async {
      setState(() {
        showProgress = true;
      });
      String path = "create/$username";
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
      // final response = await http
      //     .get(Uri.parse(globals.BASE_URL_POSTMAN+path));

      var data =  {
        "username": username,
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "createdDate": formattedDate
      };

      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.post(Uri.parse(globals.BASE_URL_POSTMAN+path), headers: headers,
          body:  json.encode(<String, String>{
            'username': username,
            'email':emailController.text.trim(),
            'password': passwordController.text.trim(),
            'createdDate' :formattedDate
          }),);
      print(response.body);
      if (response.statusCode == 200) {
        print("Success ! ");
        setState(() {
          showProgress = false;
          authenticated = true;
        });
        Fluttertoast.showToast(
            msg: 'Welcome to the club $username 😎 ',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        // If the server did return a 200 OK response,
        // then parse the JSON. json.decode
        return (jsonDecode(response.body));
      } else {
        setState(() {
          showProgress = false;
          authenticated = false;
        });
        // If the server did not return a 200 OK response,
        // then throw an exception.
        Fluttertoast.showToast(
            msg: 'Oops something went wrong ! ',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        throw Exception('Failed to load data');
      }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:false,
        appBar: AppBar(
          title: const Text("Join the team .. 😎"),
        ),
        body: Form(
          key: _formKey,
          child: Container(
              margin: const EdgeInsets.all(16.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 16.0, height: 2.0, color: Colors.black),
                        controller: usernameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your name',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 16.0, height: 2.0, color: Colors.black),
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 16.0, height: 2.0, color: Colors.black),
                        controller: passwordController,
                        obscureText: obscureText,
                        decoration: const InputDecoration(
                          hintText: 'password',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty || value.length < 6) {
                            return 'Please enter valid password';
                          }
                          return null;
                        },
                      )),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                            print("Email :${emailController.text}");
                            print("Password :${passwordController.text}");
                            createUser(usernameController.text.trim());
                            if(authenticated == true){
                              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                              const LoginPage()));
                            }
                            }
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if(showProgress == true) const Center(
                    child:CircularProgressIndicator()
                  ),
                  Center(
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0, right: 16),
                        decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(
                              color: Colors.amber,
                              width: 1.0, // Underline thickness
                            ))
                        ),
                        child:  TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Homepage()),
                              );
                            },
                            child:const Text(
                              "Back to login",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )),
                      ))
                ],
              )),
        ));
  }
}
