class Users{
  final String email;

  Users({
    required this.email
  });

  Map<String, String> toJson() {
    return{
        "email": this.email
    };
  }

}