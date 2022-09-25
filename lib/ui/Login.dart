import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stoneage/ui/Signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
          margin: const EdgeInsets.all(16.0),
          child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
              child:Icon(Icons.key_sharp,size: 100.0,)
              ),
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
                  'Login',
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
                      MaterialPageRoute(builder: (context) => const SignupPage()),
                    );
                  },
                  child:const Text(
                  "No Account ? Sign up here",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
              ))
        ],
      )),
    );
  }
}
