
import 'package:cloud_firestore/cloud_firestore.dart';

class Reports{
  final String desc;
  final String email;
  final String type;
  final String selected;
  final DateTime time;
  final GeoPoint? locatie;
  final String status;
  final String Url;



  Reports({
    required this.desc,
    required this.email,
    required this.type,
    required this.time,
    required this.locatie,
    required this.status,
    required this.selected,
    required this.Url
  });

  Map<String, dynamic> toJson() { // Now the values can be of any type
    return {
        "desc": this.desc,
        "email": this.email,
        "type": this.type,
        "selected" : this.selected,
        "time": this.time,
        "locatie": this.locatie,
        "status": this.status,
        "url": this.Url
    };
}

}