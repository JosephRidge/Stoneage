import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stoneage/ui/Home.dart';
import 'package:stoneage/ui/Signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool showProgress = false;
  bool isAuthenticated = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /*
  * - Sign in user
  *  params : Email , Password
  * */
  Future<bool> signInUser(String email, String password) async {
    setState(() {
      showProgress = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      setState(() {
        showProgress = false;
        isAuthenticated = true;
      });
      Fluttertoast.showToast(
          msg: 'Welcome back ${credential.user?.displayName} 😎 ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          showProgress = false;
          isAuthenticated = false;
        });
        Fluttertoast.showToast(
            msg: 'No user found for that email.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return false;
      } else if (e.code == 'wrong-password') {
        setState(() {
          showProgress = false;
          isAuthenticated = false;
        });
        Fluttertoast.showToast(
            msg: 'Wrong password provided for that user.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return false;
      }else{
        setState(() {
          showProgress = false;
          isAuthenticated = false;
        });
        Fluttertoast.showToast(
            msg: '${e.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return false;
      }
      return false;

    }
  }

  @override
  void dispose() {
    super.dispose();
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
  }
  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:false,
        body:Form(
      key: _formKey,
      child: Column(
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
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                 signInUser(emailController.text.trim(),passwordController.text.trim());
                    if(isAuthenticated){
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      const Homepage()));
                    }
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
            (showProgress == true)? const CircularProgressIndicator():const Text(" ")

          ]
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
      ),
    ));
  }
}
