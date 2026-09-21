import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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

      default:
        throw UnsupportedError('Platform Firebase belum dikonfigurasi.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDNrs21Uyt2UzCzoa3khPxbjd5fK3TUpAo',
    appId: '1:653568203298:web:005a51d25bd5456812087b',
    messagingSenderId: '653568203298',
    projectId: 'fir-tugas2kelmobile',
    authDomain: 'fir-tugas2kelmobile.firebaseapp.com',
    storageBucket: 'fir-tugas2kelmobile.firebasestorage.app',
    measurementId: 'G-CGDXC6XCK5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbi6wNjHSQk9pejvv0suwRdonm-05B858',
    appId: '1:653568203298:android:bbdc711be3adb76d12087b',
    messagingSenderId: '653568203298',
    projectId: 'fir-tugas2kelmobile',
    storageBucket: 'fir-tugas2kelmobile.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbEHr7cuT70lbRIVa-d8PEGJkKn5fpB5Q',
    appId: '1:653568203298:ios:f86863e53efc561112087b',
    messagingSenderId: '653568203298',
    projectId: 'fir-tugas2kelmobile',
    storageBucket: 'fir-tugas2kelmobile.firebasestorage.app',
    iosBundleId: 'com.example.tugas2',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbEHr7cuT70lbRIVa-d8PEGJkKn5fpB5Q',
    appId: '1:653568203298:ios:f86863e53efc561112087b',
    messagingSenderId: '653568203298',
    projectId: 'fir-tugas2kelmobile',
    storageBucket: 'fir-tugas2kelmobile.firebasestorage.app',
    iosBundleId: 'com.example.tugas2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDNrs21Uyt2UzCzoa3khPxbjd5fK3TUpAo',
    appId: '1:653568203298:web:56f35d343ecf0c4812087b',
    messagingSenderId: '653568203298',
    projectId: 'fir-tugas2kelmobile',
    authDomain: 'fir-tugas2kelmobile.firebaseapp.com',
    storageBucket: 'fir-tugas2kelmobile.firebasestorage.app',
    measurementId: 'G-Q0DVCBN5FM',
  );
}
