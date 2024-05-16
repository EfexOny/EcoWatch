import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryWorkPage extends StatefulWidget {
  const HistoryWorkPage({super.key});

  @override
  State<HistoryWorkPage> createState() => _HistoryWorkPageState();
}
final user = FirebaseAuth.instance.currentUser!;
final firestore = FirebaseFirestore;
final reportsQuery = FirebaseFirestore.instance.collection('reports').orderBy('type').where("selected", isEqualTo:user.email!).where("status", isEqualTo: "Resolved");

class _HistoryWorkPageState extends State<HistoryWorkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Text("History ",style: GoogleFonts.montserrat(
              fontSize: 36,
              color: Colors.black,
              letterSpacing: 20,
                ),),
          ),
          Expanded(child: 
              FirestoreListView<Map<String, dynamic>>(
              query: reportsQuery,
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> user = snapshot.data();
                return Padding(
              padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
              child: Container(
                height: MediaQuery.of(context).size.height*0.20,
                width: double.infinity,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blueGrey
                  // gradient: LinearGradient(colors: [Colors.blueAccent,Colors.cyanAccent],begin:Alignment.topLeft ,end: Alignment.bottomLeft)
                ) ,
    
    
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "${user['type']}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Text(
                          "${user['desc']}",
                          style: const TextStyle(fontSize: 16.0),
                        ),

                       Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RawMaterialButton(onPressed: () {
                          print("Accept");
                        },
                        child: 
                          Text("Accept"),
                          ),

                       ],) 
                        
                        
                      ],
                    ),
                  ),
                ),
    
              ),
            );
              },
            )
            
          ),
        
        ],
    
      ),
    );
  }
}