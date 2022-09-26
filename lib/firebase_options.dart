// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD5A88bSn5q27o4058BAgxbltEOpe89eSk',
    appId: '1:17834647045:web:09a746baf100aeb3c4c66c',
    messagingSenderId: '17834647045',
    projectId: 'stoneagetechv1',
    authDomain: 'stoneagetechv1.firebaseapp.com',
    storageBucket: 'stoneagetechv1.appspot.com',
    measurementId: 'G-12LSL2KD0F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9Hzk6zeg47oymuc__33PiWesd5iR6BXw',
    appId: '1:17834647045:android:fa833130ce8c925ec4c66c',
    messagingSenderId: '17834647045',
    projectId: 'stoneagetechv1',
    storageBucket: 'stoneagetechv1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7VMrCA7qf6YHjA-vecKOKIcvMEdW0EnY',
    appId: '1:17834647045:ios:ae1d47089ea7ff05c4c66c',
    messagingSenderId: '17834647045',
    projectId: 'stoneagetechv1',
    storageBucket: 'stoneagetechv1.appspot.com',
    iosClientId: '17834647045-eprcr9s0a088ool8i17u59kaqnisleir.apps.googleusercontent.com',
    iosBundleId: 'com.example.stoneage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD7VMrCA7qf6YHjA-vecKOKIcvMEdW0EnY',
    appId: '1:17834647045:ios:ae1d47089ea7ff05c4c66c',
    messagingSenderId: '17834647045',
    projectId: 'stoneagetechv1',
    storageBucket: 'stoneagetechv1.appspot.com',
    iosClientId: '17834647045-eprcr9s0a088ool8i17u59kaqnisleir.apps.googleusercontent.com',
    iosBundleId: 'com.example.stoneage',
  );
}