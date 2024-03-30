import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:da/models/reports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}
  final user = FirebaseAuth.instance.currentUser!;

  final db = FirebaseFirestore.instance;
class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(45.8666667, 27.4166667),zoom: 20)),
          floatingActionButton: FloatingActionButton(onPressed: () async{
            try{
              Reports rep = Reports(desc:"da" , email:user.email! , time: DateTime(2017,9,7,17,30));
              await db.collection("reports").add(rep.toJson());
                }
                catch (error){
                  print(error);
                }
              }
          ),    
      );
      
  }

}
