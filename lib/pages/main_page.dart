import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:da/pages/home_page.dart';
import 'package:da/pages/mod/mod_home.dart';
import 'package:da/pages/worker/worker_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  Future<Widget> _handleUserStatus(User user) async {
    final userStatus = await fetchUserStatus(user.email!);
    print(userStatus);
    if (userStatus == 'mod') {
      return ModHomePage(); // Assuming ModHomePage exists
    } else if(userStatus == 'midman'){
      return WorkerHome(); 
    }
    else{
      return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            return FutureBuilder<Widget>(
              future: _handleUserStatus(user),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return LoginPage();
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

// Replace this with your actual method to fetch user status from Firebase
Future<String> fetchUserStatus(String userEmail) async {
  // Implement your logic to retrieve user status from Firebase here
  // This example assumes a user collection with an "email" field and a "status" field

  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docSnapshot = querySnapshot.docs.first;
      final data = docSnapshot.data();
      return data?['status'] ?? 'normal'; // Handle cases where 'status' is missing
    } else {
      // Handle case where user with the email is not found
      return 'unknown';
    }
  } catch (error) {
    // Handle network errors or other exceptions
    print("Error fetching user status: $error");
    return 'unknown';
  }
}