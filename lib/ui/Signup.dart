import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stoneage/ui/Home.dart';
import 'package:stoneage/ui/Login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
