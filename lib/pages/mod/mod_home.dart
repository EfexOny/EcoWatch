import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:da/pages/login_page.dart';
import 'package:da/pages/main/account.dart';
import 'package:da/pages/main/map.dart';
import 'package:da/pages/mod/reports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ModHomePage extends StatefulWidget {
  const ModHomePage({super.key});

  @override
  State<ModHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<ModHomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _Selindex = 0;

  void _Navigate(int index){
    setState((){
      _Selindex = index;
    });
  }

  final List<Widget> _pages =[
   AccountPage(),
   ReportsPage()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: 
      
      CurvedNavigationBar(
        onTap: _Navigate,
        backgroundColor: Colors.green.shade300,
        color: Colors.green.shade500,
        animationCurve: Easing.legacy,
        animationDuration: Duration(milliseconds: 200),
        items: [
        Icon(Icons.home),
        Icon(Icons.map_outlined),
      ],),
      body: _pages[_Selindex],
    );
  }
}
