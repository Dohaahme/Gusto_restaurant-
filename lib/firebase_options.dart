// lib/firebase_options.dart

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD98IzsvQEYccKnfbzkx5_t7pVOM1yps9Q',
    authDomain: 'gusto-c2479.firebaseapp.com',
    projectId: 'gusto-c2479',
    storageBucket: 'gusto-c2479.appspot.com',
    messagingSenderId: '363485895142',
    appId: '1:363485895142:web:931c29cd5cd6795ac69e27',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD98IzsvQEYccKnfbzkx5_t7pVOM1yps9Q',
    appId: '1:363485895142:android:e795195f2b5e8907c69e27',
    messagingSenderId: '363485895142',
    projectId: 'gusto-c2479',
    storageBucket: 'gusto-c2479.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD98IzsvQEYccKnfbzkx5_t7pVOM1yps9Q',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: '363485895142',
    projectId: 'gusto-c2479',
    storageBucket: 'gusto-c2479.appspot.com',
    iosBundleId: 'YOUR_IOS_BUNDLE_ID',
  );

  static const FirebaseOptions macos = ios;
}
