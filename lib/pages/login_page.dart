import 'package:da/pages/home_page.dart';
import 'package:da/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // controller texte sa nu uit

  final _email = TextEditingController();
  final _parola = TextEditingController();

  signIn()  {
       FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _email.text.trim(), password: _parola.text.trim());
  }


@override
  void dispose() {
    _email.dispose();
    _parola.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello,",
                style: 
                GoogleFonts.montserrat(
                  fontSize: 36,
                )
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Email"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _parola,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Password"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: GestureDetector(onTap: () async {
                      await signIn();
                    },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w200),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You don't have an account?",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                 GestureDetector(onTap:() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                // TO CHANGE
                            return RegisterPage();
                          }));
                        }, 
                   child: Text("Register now",
                                   style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue
                                   ),),
                 )
              ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
