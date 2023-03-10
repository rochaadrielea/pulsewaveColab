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
    apiKey: 'AIzaSyB-5ugM-6Y-T4Q7j-rfq9rrHa4n0HHRwWM',
    appId: '1:262940002970:web:5f9c3b44e47cdb79eced23',
    messagingSenderId: '262940002970',
    projectId: 'temple-guard-project',
    authDomain: 'temple-guard-project.firebaseapp.com',
    storageBucket: 'temple-guard-project.appspot.com',
    measurementId: 'G-2DBW4YHF5G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3s4ARXTYt69pwxmXGwSgA_Mudha_PhqA',
    appId: '1:262940002970:android:f223768eb468657beced23',
    messagingSenderId: '262940002970',
    projectId: 'temple-guard-project',
    storageBucket: 'temple-guard-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWufa-mhNUVggw7UG4ZhKMczdcwrxySf0',
    appId: '1:262940002970:ios:865e701d50c9443feced23',
    messagingSenderId: '262940002970',
    projectId: 'temple-guard-project',
    storageBucket: 'temple-guard-project.appspot.com',
    iosClientId: '262940002970-2mpdp1ek5jnfi4gqo154nstsso3kb48h.apps.googleusercontent.com',
    iosBundleId: 'ch.pulsewave.templeGuard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWufa-mhNUVggw7UG4ZhKMczdcwrxySf0',
    appId: '1:262940002970:ios:865e701d50c9443feced23',
    messagingSenderId: '262940002970',
    projectId: 'temple-guard-project',
    storageBucket: 'temple-guard-project.appspot.com',
    iosClientId: '262940002970-2mpdp1ek5jnfi4gqo154nstsso3kb48h.apps.googleusercontent.com',
    iosBundleId: 'ch.pulsewave.templeGuard',
  );
}
