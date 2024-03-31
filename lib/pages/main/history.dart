
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}
final usersQuery = FirebaseFirestore.instance.collection('reports').orderBy('type');

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
  
    
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Text("History",style: GoogleFonts.montserrat(
              fontSize: 36,
              color: Colors.black,
              letterSpacing: 20,
                ),),
          ),
          Expanded(child: 
              FirestoreListView<Map<String, dynamic>>(
              query: usersQuery,
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> user = snapshot.data();

                // return Column(mainAxisAlignment: MainAxisAlignment.center,
                //   children: [Text('Type: ${user['type']}'),
                //   Text('desc: ${user['desc']}')
                  
                //   ]
                  
                //   ,
                // );
String formattedDate = user['time'].toString();

                return Padding(
              padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
              child: Container(
                height: MediaQuery.of(context).size.height*0.25,
                width: double.infinity,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(colors: [Colors.blueAccent,Colors.cyanAccent],begin:Alignment.topLeft ,end: Alignment.bottomLeft)
                ) ,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.report_problem_rounded),
                          Text("${user['type']}"),
                          
                        ],
                       ),
                       Text("${user['desc']}")
                     ],
                   ),
                  
                    ),
                ),
              ),
            );
              },
            )
          )
        ],
      ),
    );
  }
}