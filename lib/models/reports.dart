class Reports{
  final String desc;
  final String email;
  final String type;
  final DateTime time;

  Reports({
    required this.desc,
    required this.email,
    required this.type,
    required this.time
  });

  Map<String, dynamic> toJson() { // Now the values can be of any type
    return {
        "desc": this.desc,
        "email": this.email,
        "type": this.type,
        "time": this.time
    };
}

}