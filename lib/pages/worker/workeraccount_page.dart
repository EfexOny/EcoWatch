

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerPage extends StatefulWidget {
  const WorkerPage({super.key});

  @override
  State<WorkerPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<WorkerPage> {

  final user = FirebaseAuth.instance.currentUser!;




  @override
  Widget build(BuildContext context) {
  final query = FirebaseFirestore.instance.collection("reports").where("selected",isEqualTo: user.email!).where("status",isEqualTo: "Resolving");

    return Scaffold(
      body: Column(children: [
          Card(user.email!),

          SizedBox(height: 25),

          Divider(thickness: 0.5,),

          Text("Active",style: GoogleFonts.montserrat(
              fontSize: 36,
              color: Colors.black,
                ),),
          Padding(
            padding: const EdgeInsets.only(left: 40,right: 40),
            child: Container(
              height: 400,
              width: 400,
              child: FirestoreListView(query: query, itemBuilder: (context, doc) {
                QueryDocumentSnapshot<Map<String, dynamic>> user = doc;
                return Container(
                  decoration: BoxDecoration(
                  ),
                  child: Column(children: [
                  Text(user["type"]),
                  Text(user["desc"]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    
                    OutlinedButton(onPressed: () {
                      // TO DO 
                    }, child: Text("Done"))

                  ],)
                ]
                
                ,),

                );
              },),
            ),
          )
        
            

      ],),
    );
  }
}

Widget Card(String text){
  return Padding(
              padding: EdgeInsets.only(left: 20 ,right: 20,top: 40),
              child: Container(
                      width: 300,
                      height: 120 ,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(16)),
                      child:Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(text,overflow: TextOverflow.fade,),
                          OutlinedButton(
                            onPressed: () { 
                                FirebaseAuth.instance.signOut();
                          }, 
                          child: Text(" Sign out",style: TextStyle(color: Colors.black),),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                          ),
                          )
                        ],
                      )
                ),
            );
}