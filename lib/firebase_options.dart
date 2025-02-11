// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyA6zUVWJ0P3IH5Kick82BoDy6nWmAqWBJA',
    appId: '1:64134178012:web:35be1936b7eb7b6d420019',
    messagingSenderId: '64134178012',
    projectId: 'ief-app-f2d4a',
    authDomain: 'ief-app-f2d4a.firebaseapp.com',
    storageBucket: 'ief-app-f2d4a.appspot.com',
    measurementId: 'G-1D4C28N1HT',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCj1SECgrxXlnOF3YNdjPGUkFPpRrP7jv0',
    appId: '1:64134178012:ios:c3428b27619d1561420019',
    messagingSenderId: '64134178012',
    projectId: 'ief-app-f2d4a',
    storageBucket: 'ief-app-f2d4a.appspot.com',
    iosBundleId: 'com.example.qrApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCj1SECgrxXlnOF3YNdjPGUkFPpRrP7jv0',
    appId: '1:64134178012:ios:c3428b27619d1561420019',
    messagingSenderId: '64134178012',
    projectId: 'ief-app-f2d4a',
    storageBucket: 'ief-app-f2d4a.appspot.com',
    iosBundleId: 'com.example.qrApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA6zUVWJ0P3IH5Kick82BoDy6nWmAqWBJA',
    appId: '1:64134178012:web:b118edbcf62053f9420019',
    messagingSenderId: '64134178012',
    projectId: 'ief-app-f2d4a',
    authDomain: 'ief-app-f2d4a.firebaseapp.com',
    storageBucket: 'ief-app-f2d4a.appspot.com',
    measurementId: 'G-JTHR6M3CPB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXxbkiGzePbLg5EPaXTBOaKT9rqpjWwvU',
    appId: '1:64134178012:android:7da25cf9b516d2d5420019',
    messagingSenderId: '64134178012',
    projectId: 'ief-app-f2d4a',
    storageBucket: 'ief-app-f2d4a.appspot.com',
  );

}