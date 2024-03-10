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
    apiKey: 'AIzaSyD8e5vN8_75lkc3I7E1m0T88Uwn43ehftM',
    appId: '1:715565594584:web:63c4e519975f425355e4ad',
    messagingSenderId: '715565594584',
    projectId: 'monprojet-a6208',
    authDomain: 'monprojet-a6208.firebaseapp.com',
    storageBucket: 'monprojet-a6208.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDl0D6q129auaT6Mo3QWVoAdQLutRJJ8f4',
    appId: '1:715565594584:android:5d7d77ae8d9d676755e4ad',
    messagingSenderId: '715565594584',
    projectId: 'monprojet-a6208',
    storageBucket: 'monprojet-a6208.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbuI-S0Nuj1xO3dABiyJnyoRb_pKOUxgU',
    appId: '1:715565594584:ios:d43b2312e31822cc55e4ad',
    messagingSenderId: '715565594584',
    projectId: 'monprojet-a6208',
    storageBucket: 'monprojet-a6208.appspot.com',
    iosBundleId: 'com.example.projetFormation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbuI-S0Nuj1xO3dABiyJnyoRb_pKOUxgU',
    appId: '1:715565594584:ios:5bc68051e8ff6cdf55e4ad',
    messagingSenderId: '715565594584',
    projectId: 'monprojet-a6208',
    storageBucket: 'monprojet-a6208.appspot.com',
    iosBundleId: 'com.example.projetFormation.RunnerTests',
  );
}
