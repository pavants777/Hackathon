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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBIuRS-aEu46uHAxyYA3g1gUNX2qRvMFbU',
    appId: '1:754779193821:web:7e2541e433c6ccfd1c3634',
    messagingSenderId: '754779193821',
    projectId: 'cmc1-820fd',
    authDomain: 'cmc1-820fd.firebaseapp.com',
    storageBucket: 'cmc1-820fd.appspot.com',
    measurementId: 'G-K06D5M7NVH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbcWWvVTLVeDlYB9s9uzcR_5uSlO3EZHY',
    appId: '1:754779193821:android:1a9ec8fcecd9faae1c3634',
    messagingSenderId: '754779193821',
    projectId: 'cmc1-820fd',
    storageBucket: 'cmc1-820fd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXlrub_RNZaFaep0eDEBg0p6bDoHGMEKs',
    appId: '1:754779193821:ios:8d364e7c081faefe1c3634',
    messagingSenderId: '754779193821',
    projectId: 'cmc1-820fd',
    storageBucket: 'cmc1-820fd.appspot.com',
    iosBundleId: 'com.example.hackathon',
  );
}