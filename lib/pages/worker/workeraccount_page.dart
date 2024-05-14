

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WorkerPage extends StatefulWidget {
  const WorkerPage({super.key});

  @override
  State<WorkerPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<WorkerPage> {

  final user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(onPressed: () async {
           final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: user.email)
            .get();

          final snapshot = querySnapshot.docs.first;

          final now = snapshot.get("work");

          final ref = snapshot.reference;

          if(now == "Idle")
            ref.update({
              "work":"Active",
            });
          else
            ref.update({
              "work":"Idle",
            });

          },
          color: Colors.blue,
          child: Text("Queue for work")
          ),
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