import 'package:firebase_auth/firebase_auth.dart';

String username = "";
String password = "";
bool authenticated = false;
const String BASE_URL_POSTMAN ='https://897d-41-90-176-50.eu.ngrok.io/api/v1/users/'; // exposed via ngrok
const getAllUserPaths ='';

//Check current user auth state :
checkAuthState(){
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      authenticated = false;
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
      authenticated = true;
    }
  });
}

// get user details - returns a Stream
getUserProfileInfo(){
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user != null) {
      print(user.uid);
    }
  });
}

/*
* signout user
* - important especially when it comes to ios
* - Firebase iOS SDK persists authentication state to the system keychain
* - doc: https://firebase.google.com/docs/auth/flutter/password-auth#sign_in_a_user_with_an_email_address_and_password
* */
signOut() async {
  await FirebaseAuth.instance.signOut();
}
