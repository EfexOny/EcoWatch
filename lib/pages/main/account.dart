

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("as: " + user.email!)),
          MaterialButton(onPressed: (){
              FirebaseAuth.instance.signOut();
          },
          color: Colors.amberAccent,
          child: Text("Sign Out"),
          )
        ],
      )
    );
  }
}