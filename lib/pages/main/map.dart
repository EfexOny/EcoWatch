import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:da/models/reports.dart';
import 'package:image_picker/image_picker.dart'; // Assuming this is your reports model class

class MapPage extends StatefulWidget {
  const MapPage({Key? key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Future<List<GeoPoint>> _markersFuture;
  final _desc = TextEditingController();
  final _type = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;

  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }

  Future<GeoPoint?> getCurrentLocation() async {
    bool hasPermission = await requestLocationPermission();
    if (!hasPermission) {
      return null;
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    return GeoPoint(position.latitude, position.longitude);
  }

  Future<List<GeoPoint>> getReportsWithLocations() async {
    final reports = await FirebaseFirestore.instance
        .collection('reports')
        .where('locatie', isNotEqualTo: null) 
        .get();
    return reports.docs.map((doc) => doc['locatie'] as GeoPoint).toList();
  }

  @override
  void initState() {
    super.initState();
    _markersFuture = getReportsWithLocations();
  }

  String catre = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      body: FutureBuilder<List<GeoPoint>>(
        future: _markersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final locations = snapshot.data!;
            final markers = locations.map((location) => Marker(
              markerId: MarkerId(location.toString()),
              position: LatLng(location.latitude, location.longitude),
            )).toSet();
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(target: LatLng(45.83783783783784, 27.413997318696683), zoom: 15),
                  markers: markers,
                  mapType: MapType.normal,
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.report),
        onPressed: () async {
          try {
            showDialog(
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
                              onPressed: () async {
                                ImagePicker imagePicker = ImagePicker();

                                XFile? file = await imagePicker.pickImage(source: ImageSource.camera);


                                catre = file!.path;
                                

                              },
                              child: Text('Take a Photo'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                String nume = DateTime.now().millisecondsSinceEpoch.toString();


                                Reference reference = FirebaseStorage.instance.ref();
                                Reference directorImagini = reference.child(user.email!);
                                Reference upImagine = directorImagini.child(nume);
  

                                try {
                                upImagine.putFile(File(catre));  
                                  
                                } catch (e) {
                                  print(e);
                                }

                                await upImagine.putFile(File(catre)); 
                                String downloadUrl = await upImagine.getDownloadURL();
                                GeoPoint? location = await getCurrentLocation();
                                Reports rep = Reports(desc: _desc.text.trim(), type: _type.text.trim(), email: user.email!, locatie: location,  selected: "Not assigned",time: DateTime.now(),status: "Pending",Url: downloadUrl);
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
                );
              },
            );
          } catch (error) {
            print(error);
          }
        },
      ),
    );
  }
}
