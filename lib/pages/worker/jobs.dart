import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:da/pages/worker/available_page.dart';
import 'package:da/pages/worker/history_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Future<Widget> _handleUserStatus(User user) async {
      final userStatus = await fetchMidmanStatus(user.email!);
      if (userStatus == 'Idle') {
        return AvaialableWorkPage(); 
      } else {
        return AvaialableWorkPage();
      }
    }

    return FutureBuilder<Widget>(
      future: _handleUserStatus(FirebaseAuth.instance.currentUser!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return snapshot.data ?? Container(); // Handle potential null case
        }
      },
    );
  }
}

Future<String> fetchMidmanStatus(String userEmail) async {
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
      return data?['work'] ?? 'Idle'; // Handle cases where 'status' is missing
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
