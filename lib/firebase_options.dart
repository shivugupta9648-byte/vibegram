// File: lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

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
          'DefaultFirebaseOptions have not been configured for this platform - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBgKFIyXTIumq-edRfxqm0b36_bWR3oRokM',
    appId: '1:53995384110:web:vibegramf1c94',
    messagingSenderId: '53995384110',
    projectId: 'vibegram-f1c94',
    authDomain: 'vibegram-f1c94.firebaseapp.com',
    storageBucket: 'vibegram-f1c94.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgKFIyXTIumq-edRfxqm0b36_bWR3oRokM',
    appId: '1:53995384110:android:vibegramf1c94',
    messagingSenderId: '53995384110',
    projectId: 'vibegram-f1c94',
    storageBucket: 'vibegram-f1c94.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgKFIyXTIumq-edRfxqm0b36_bWR3oRokM',
    appId: '1:53995384110:ios:vibegramf1c94',
    messagingSenderId: '53995384110',
    projectId: 'vibegram-f1c94',
    storageBucket: 'vibegram-f1c94.appspot.com',
  );
  
  static const FirebaseOptions macos = ios;
  static const FirebaseOptions windows = web;
}