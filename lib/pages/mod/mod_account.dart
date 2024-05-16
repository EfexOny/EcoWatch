

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:url_launcher/url_launcher.dart';

class ModAccountPage extends StatefulWidget {
  const ModAccountPage({super.key});

  @override
  State<ModAccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<ModAccountPage> {

  final user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
final reportsQuery = FirebaseFirestore.instance.collection('reports').orderBy('type').where("status", isEqualTo:"Pending");

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(user.email!),

          Divider(),
          
          Text("Verify",style: GoogleFonts.montserrat(
              fontSize: 36,
              color: Colors.black,
                ),),
          Padding(
            padding: const EdgeInsets.only(left: 40,right: 40),
            child: Container(
              height: 400,
              width: 400,
              child: FirestoreListView(query: reportsQuery, itemBuilder: (context, doc) {
                QueryDocumentSnapshot<Map<String, dynamic>> user = doc;
                return Container(
                  decoration: BoxDecoration(
                  ),
                  child: Column(children: [
                  Text(user["type"]),
                  Text(user["desc"]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    
                    Text(user["status"],style: TextStyle(fontSize: 20),),

                    GestureDetector(child: Icon(Icons.location_pin),
                    onTap:() {
                      
                      GeoPoint locatie;

                      locatie = user["locatie"];

                      String URL = 'https://www.google.com/maps/search/?api=1&query=${locatie.latitude},${locatie.longitude}'; 
                      launch(URL);
                    } ,)
                  ],),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(onPressed: () {
                        FirebaseFirestore.instance.collection("reports").doc(doc.id).update({
                          "status": "Acceptat"
                        });
                      }, child: Text("Accept")),
                      OutlinedButton(onPressed: () {
                        FirebaseFirestore.instance.collection("reports").doc(doc.id).update({
                          "status": "Refuzat"
                        });
                      }, child: Text("Refuza")),
                      
                    ],
                  ),
                ],
                ),

                );
              },),
            ),
          )

        ],
      )
    );
  }
}

Widget Card(String text){
  return Padding(
              padding: EdgeInsets.only(left: 40 ,right: 20,top: 40),
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
