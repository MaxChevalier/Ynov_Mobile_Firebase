import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'pages/RegisterPage.dart';
import 'pages/CreateNote.dart';
import 'pages/UpdateNote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'TPF Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: Map.fromEntries([
        MapEntry('/', (context) => HomePage()),
        MapEntry('/Register', (context) => RegisterPage()),
        MapEntry('/Login', (context) => LoginPage()),
        MapEntry('/CreateNote', (context) => CreateNote()),
        MapEntry('/EditNote', (context) => UpdateNote()),
      ])
    );
  }
}