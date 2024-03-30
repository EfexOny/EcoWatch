import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:da/pages/login_page.dart';
import 'package:da/pages/main/account.dart';
import 'package:da/pages/main/history.dart';
import 'package:da/pages/main/map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _Selindex = 0;

  void _Navigate(int index){
    setState((){
      _Selindex = index;
    });
  }

  final List<Widget> _pages =[
   AccountPage(),
   MapPage(),
   HistoryPage()
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
        Icon(Icons.history)
      ],),
      body: _pages[_Selindex],
    );
  }
}
