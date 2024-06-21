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
    apiKey: 'AIzaSyCp4G_GVXAF5UGUEAi_FpXKDMfeLovN8SQ',
    appId: '1:837512039410:web:db8df011f0189cb4cdf96b',
    messagingSenderId: '837512039410',
    projectId: 'jobfinderappdb',
    authDomain: 'jobfinderappdb.firebaseapp.com',
    storageBucket: 'jobfinderappdb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBHId2ilIIIW6TlOZrx8tdRLHSLdpdda8',
    appId: '1:837512039410:android:86ca4e1de9b7a9b7cdf96b',
    messagingSenderId: '837512039410',
    projectId: 'jobfinderappdb',
    storageBucket: 'jobfinderappdb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDd2wjEVREkfdNYoLmlqvNRWRNiAtGinrs',
    appId: '1:837512039410:ios:0ad226046a508f38cdf96b',
    messagingSenderId: '837512039410',
    projectId: 'jobfinderappdb',
    storageBucket: 'jobfinderappdb.appspot.com',
    iosBundleId: 'com.example.jobFinder',
  );
}
