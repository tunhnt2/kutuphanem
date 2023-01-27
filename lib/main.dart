import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kutuphanem/firebase_options.dart';
import 'package:kutuphanem/screens/login.dart';
import 'package:kutuphanem/screens/statutAuth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Kütüphanem",
      home: Statut(),
    );
  }
}