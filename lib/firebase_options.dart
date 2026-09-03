import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
          'you can reconfigure this by running the Firebase CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBgKFiYXTiumq-edRfXqm0b36_bWR3oRokM',
    appId: '1:905389659878:web:e55efe4d26d590cb110d27',
    messagingSenderId: '905389659878',
    projectId: 'vibegram-f1c94',
    authDomain: 'vibegram-f1c94.firebaseapp.com',
    storageBucket: 'vibegram-f1c94.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgKFiYXTiumq-edRfXqm0b36_bWR3oRokM',
    appId: '1:53995384110:android:vibegramf1c94',
    messagingSenderId: '53995384110',
    projectId: 'vibegram-f1c94',
    storageBucket: 'vibegram-f1c94.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgKFiYXTiumq-edRfXqm0b36_bWR3oRokM',
    appId: '1:53995384110:ios:vibegramf1c94',
    messagingSenderId: '53995384110',
    projectId: 'vibegram-f1c94',
    storageBucket: 'vibegram-f1c94.appspot.com',
  );

  static const FirebaseOptions macos = ios;
  static const FirebaseOptions windows = web;
}