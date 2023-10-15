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
    apiKey: 'AIzaSyDxuIHPdtri-CRjfe0CVBDTk4Yu7hVT-es',
    appId: '1:1046163958640:web:f8a468f37f47768876fdb5',
    messagingSenderId: '1046163958640',
    projectId: 'ask-chatgpt-99a9f',
    authDomain: 'ask-chatgpt-99a9f.firebaseapp.com',
    storageBucket: 'ask-chatgpt-99a9f.appspot.com',
    measurementId: 'G-KN7KH3M3RG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKGcDRr6TPZ5Nk_vbiHWIQW4r8VR7u14Q',
    appId: '1:1046163958640:android:e9ef0c2c66f7406176fdb5',
    messagingSenderId: '1046163958640',
    projectId: 'ask-chatgpt-99a9f',
    storageBucket: 'ask-chatgpt-99a9f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4km5PVM9nIE2uQW7JYy4NbQOXcoRu27M',
    appId: '1:1046163958640:ios:68ac055673597db776fdb5',
    messagingSenderId: '1046163958640',
    projectId: 'ask-chatgpt-99a9f',
    storageBucket: 'ask-chatgpt-99a9f.appspot.com',
    iosBundleId: 'com.example.askChatgpt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4km5PVM9nIE2uQW7JYy4NbQOXcoRu27M',
    appId: '1:1046163958640:ios:8ed7f82c0611dcca76fdb5',
    messagingSenderId: '1046163958640',
    projectId: 'ask-chatgpt-99a9f',
    storageBucket: 'ask-chatgpt-99a9f.appspot.com',
    iosBundleId: 'com.example.askChatgpt.RunnerTests',
  );
}
