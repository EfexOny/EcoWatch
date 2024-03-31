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
  final _formKey = GlobalKey<FormState>();
  final _desc = TextEditingController();
  final _type = TextEditingController();

  final db = FirebaseFirestore.instance;

class _MapPageState extends State<MapPage> {

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      body: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(45.8666667, 27.4166667),zoom: 20)),
          floatingActionButton: FloatingActionButton(
            
            onPressed: () async{
            try{showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
                    title: Text('Raporteaza'),
                    content: Form(
                      key: GlobalKey<FormState>(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _type,
                            decoration: InputDecoration(labelText: 'Type'),
                          ),
                          TextFormField(
                            controller: _desc,
                            decoration: InputDecoration(labelText: 'Description'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {

                                  // Handle "Take a Photo" button press
                                },
                                child: Text('Take a Photo'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Reports rep = Reports(desc:_desc.text.trim() , type: _type.text.trim(), email:user.email! , time: DateTime.now());
                                  await db.collection("reports").add(rep.toJson());
                                  Navigator.pop(context, true);
                                  // Handle "Send" button press
                                },
                                child: Text('Send'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ); ;
    },
  );
                

              // Reports rep = Reports(desc:"Nu stiu ce e aici" , type: "Plastic", email:user.email! , time: DateTime(2017,9,7,17,30));
              // await db.collection("reports").add(rep.toJson());
                }
                catch (error){
                  print(error);
                }
              }
          ),    
      );
      
  }
}
