

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerPage extends StatefulWidget {
  const WorkerPage({super.key});

  @override
  State<WorkerPage> createState() => _AccountPageState();
}
final utilizator = FirebaseAuth.instance.currentUser!;
                      String smek = "";


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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(child: Icon(Icons.photo),
                      onTap: () { 
                         final List<String> poze = [user["url"]]; 
                              PopupBanner(useDots: false,
                                context: context, images: poze, onClick: (index) {
                                print(index);
                              }).show();
                      },
                      ),
                      Spacer(),
                    
                    OutlinedButton(onPressed: () {
                      FirebaseFirestore.instance.collection("users").where("email",isEqualTo: utilizator.email).get()
                              .then((value) {
                                FirebaseFirestore.instance.collection("users").doc(value.docs.first.id).update({
                                    "active": "false"
                                });
                              });
                              
                      FirebaseFirestore.instance.collection("reports").doc(doc.id).update(
                        {
                            "status": "Resolved",                          
                        }
                      );
                      
                              
                        
                    }, child: Text("Done")),

                    Spacer(),

                    GestureDetector(child: Icon(Icons.location_pin),
                    onTap:() {
                      
                      GeoPoint locatie;

                      locatie = user["locatie"];

                      String URL = 'https://www.google.com/maps/search/?api=1&query=${locatie.latitude},${locatie.longitude}'; 
                      launch(URL);
                    } ,)
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
                        color: Colors.green.shade500,
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