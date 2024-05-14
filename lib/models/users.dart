class Users{
  final String email;
  final String status;

  Users({
    required this.email,
    required this.status
  });

  Map<String, String> toJson() {
    return{
        "email": this.email,
        "status": this.status,
    };
  }

}