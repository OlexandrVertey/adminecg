import 'dart:io';

import 'package:adminecg/admin_ecg_app.dart';
import 'package:adminecg/common/di/app_dependency_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCsAsgxale4wngdWdpmj3ERo1zLjiEQIek",
      authDomain: "ecg-practice-app.firebaseapp.com",
      projectId: "ecg-practice-app",
      storageBucket: "ecg-practice-app.firebasestorage.app",
      messagingSenderId: "302817283166",
      appId: "1:302817283166:web:eeda1317a98b486108f8cf",
      measurementId: "G-END170J84B",
    ),
  );
  }
  HttpOverrides.global = MyHttpOverrides();
  runAppWithInjectedDependencies(app: const MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
