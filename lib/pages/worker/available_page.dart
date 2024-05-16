import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:da/pages/mod/reports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:url_launcher/url_launcher.dart';

class AvaialableWorkPage extends  StatefulWidget {
  const AvaialableWorkPage({super.key});

  @override
  State<AvaialableWorkPage>  createState() => _AvaialableWorkPageState();
}
final utilizator = FirebaseAuth.instance.currentUser!;
final firestore = FirebaseFirestore;
final reportsQuery = FirebaseFirestore.instance.collection('reports').orderBy('type').where("status", isEqualTo:"Acceptat");
                              String smek = "";

  

class  _AvaialableWorkPageState extends State<AvaialableWorkPage> {


    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Text("Available",style: GoogleFonts.montserrat(
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
                String ReportId = snapshot.reference.id;
                return Padding(
              padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
              child: Container(
                height: MediaQuery.of(context).size.height*0.20,
                width: double.infinity,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.green.shade500
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
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                    


                    GestureDetector(child: Icon(Icons.location_pin),
                    onTap:() {
                      
                      GeoPoint locatie;

                      locatie = user["locatie"];

                      String URL = 'https://www.google.com/maps/search/?api=1&query=${locatie.latitude},${locatie.longitude}'; 
                      launch(URL);
                    } ,)
                              ],
                            ),
                              OutlinedButton(onPressed: () {

                                FirebaseFirestore.instance.collection("users").where("email",isEqualTo: utilizator.email).get()
                              .then((value) {
                                if(value.docs.first["active"].toString() == "false"){
                                      FirebaseFirestore.instance.collection("users").doc(value.docs.first.id).update({
                                          "active": "true" 
                                    });
                                FirebaseFirestore.instance.collection("reports").doc(snapshot.id).update({
                                "selected": utilizator.email!,
                                "status": "Resolving"
                              });
                                }
                                else{
                                    print("nu poti lua");
                                           ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(backgroundColor: Colors.red,
                                      duration: Duration(seconds: 5),
                                      content: Text('Ai deja un report activ.'),
                                    )
                                  );
                                }
                              });
                              
                              


                            }, child: Text("Accept",style: TextStyle(color: Colors.black),),
                            style: ButtonStyle(
                               shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                               backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                            ),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),



                              // Text("${user['type']}"),
                              //   Text("${user['desc']}",
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

