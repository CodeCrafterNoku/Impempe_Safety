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
    apiKey: 'AIzaSyDI00cRRtUWNj32vl0lqCPbsd24vI-QZ_A',
    appId: '1:688055618668:web:a05a7af43b7531bb719c49',
    messagingSenderId: '688055618668',
    projectId: 'impempe-b8542',
    authDomain: 'impempe-b8542.firebaseapp.com',
    storageBucket: 'impempe-b8542.appspot.com',
    measurementId: 'G-15ERPMP13E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQTrxI7RyAIaj4oar3H_XS7HlSTNMQsdc',
    appId: '1:688055618668:android:bbc3cc4d69536242719c49',
    messagingSenderId: '688055618668',
    projectId: 'impempe-b8542',
    storageBucket: 'impempe-b8542.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWPOINAmGEEU-bFVcpq5ZQN8amp2i984Y',
    appId: '1:688055618668:ios:b68ba1d379f06404719c49',
    messagingSenderId: '688055618668',
    projectId: 'impempe-b8542',
    storageBucket: 'impempe-b8542.appspot.com',
    iosBundleId: 'com.example.mpempe3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCWPOINAmGEEU-bFVcpq5ZQN8amp2i984Y',
    appId: '1:688055618668:ios:b68ba1d379f06404719c49',
    messagingSenderId: '688055618668',
    projectId: 'impempe-b8542',
    storageBucket: 'impempe-b8542.appspot.com',
    iosBundleId: 'com.example.mpempe3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDI00cRRtUWNj32vl0lqCPbsd24vI-QZ_A',
    appId: '1:688055618668:web:67740e6a229bf30f719c49',
    messagingSenderId: '688055618668',
    projectId: 'impempe-b8542',
    authDomain: 'impempe-b8542.firebaseapp.com',
    storageBucket: 'impempe-b8542.appspot.com',
    measurementId: 'G-TYV2D206FY',
  );



}