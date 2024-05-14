
import 'package:da/pages/intro_page.dart';
import 'package:da/pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyBTgkL7ChQaYhRm2F15zRQnGbDY-jn4SGE", 
    appId: "1:579889301523:web:684f2324998d3ef4d217e6", 
    messagingSenderId: "579889301523", 
    projectId: "ecowatch-e1cfc",
    storageBucket: "ecowatch-e1cfc.appspot.com"
    )
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: IntroPage(),
    );
  }
}
