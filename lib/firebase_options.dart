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
    apiKey: 'AIzaSyC854Wl00slEOvRz9RDxyvTosJ67D1CwH4',
    appId: '1:541380418033:web:e9b7d1d724e5edea6ecc50',
    messagingSenderId: '541380418033',
    projectId: 'alcopper-472bb',
    authDomain: 'alcopper-472bb.firebaseapp.com',
    storageBucket: 'alcopper-472bb.firebasestorage.app',
    measurementId: 'G-7LT9GDMCD8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDz2A3bE5Y7tXoJ6c_Sv3QwAuQ2WqYjJ5Q',
    appId: '1:541380418033:android:8fb790a534a1bb8a6ecc50',
    messagingSenderId: '541380418033',
    projectId: 'alcopper-472bb',
    storageBucket: 'alcopper-472bb.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVqbPRKqFrxrB_sUjIYDxlDuWyDkiaKQ8',
    appId: '1:541380418033:ios:1eeae34684d4a95c6ecc50',
    messagingSenderId: '541380418033',
    projectId: 'alcopper-472bb',
    storageBucket: 'alcopper-472bb.firebasestorage.app',
    iosBundleId: 'com.example.alCopper',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCVqbPRKqFrxrB_sUjIYDxlDuWyDkiaKQ8',
    appId: '1:541380418033:ios:1eeae34684d4a95c6ecc50',
    messagingSenderId: '541380418033',
    projectId: 'alcopper-472bb',
    storageBucket: 'alcopper-472bb.firebasestorage.app',
    iosBundleId: 'com.example.alCopper',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC854Wl00slEOvRz9RDxyvTosJ67D1CwH4',
    appId: '1:541380418033:web:07d3173428cb266a6ecc50',
    messagingSenderId: '541380418033',
    projectId: 'alcopper-472bb',
    authDomain: 'alcopper-472bb.firebaseapp.com',
    storageBucket: 'alcopper-472bb.firebasestorage.app',
    measurementId: 'G-4ZRX0WNVDJ',
  );
}
