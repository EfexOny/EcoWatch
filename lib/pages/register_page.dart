import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:da/models/users.dart';
import 'package:da/pages/home_page.dart';
import 'package:da/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

  final db = FirebaseFirestore.instance;

class _RegisterPageState extends State<RegisterPage> {
  final _confirmParola = TextEditingController();
  final _email = TextEditingController();
  final _parola = TextEditingController();

 signUp()  {
  bool ok = true;

  // Email validation
  if (_email.text.trim().isEmpty) {
    ok = false;
    print("Please enter your email address.");
  } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z]*@[a-zA-Z0-9.-]*\.[a-zA-Z]{2,}$").hasMatch(_email.text.trim())) {
    ok = false;
    print("Please enter a valid email address.");
  }

  // Password validation (basic check)
  if (_parola.text.trim().isEmpty) {
    ok = false;
    print("Please enter a password.");
  } else if (_confirmParola.text.trim() != _parola.text.trim()) {
    ok = false;
    print("Passwords do not match.");
  }

  if (ok) {
    try {
      // Create user account using Firebase Authentication
       FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _parola.text.trim(),
      );
      
      Users us = Users(email: _email.text.trim(),status: "normal");

      db.collection("users").add(us.toJson());
      
       Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                // TO CHANGE
                            return MainPage();
                          }));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The email address is already in use by another account.');
      } else {
        print(e.message); 
      }
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Email"),
                    ),
                  ),
                ),),
                Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _parola,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Password"),
                    ),
                  ),
                ),),
                Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _confirmParola,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Confirm Password"),
                    ),
                  ),
                ),),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: GestureDetector(onTap: () async {
                      await signUp();
                    },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w200),
                      ),
                    ),
                  ),
                ),
              ),

        ]
      )
    );
  }
}