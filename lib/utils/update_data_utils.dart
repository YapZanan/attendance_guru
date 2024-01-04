import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import 'navigation_utils.dart';

class UpdateUtils {
  static Future<void> updateUser({
    required BuildContext context,
    required TextEditingController usernameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required String userId, // Pass user document ID as an argument
    required String collectionName,
  }) async {
    BuildContext currentContext = context;
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (username.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(userId)
            .update({'userName': username});
      }
      sharedPreferences.setString("userName", username);

      if (email.isNotEmpty) {
        // Check if the new email is not already in use
        QuerySnapshot snap = await FirebaseFirestore.instance
            .collection(collectionName)
            .where('email', isEqualTo: email)
            .get();

        if (snap.docs.isNotEmpty) {
          ScaffoldMessenger.of(currentContext).showSnackBar(
            const SnackBar(content: Text("Email sudah digunakan")),
          );
          return;
        }
        sharedPreferences.setString("email", email);

        // Update email if it is not in use
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(userId)
            .update({'email': email});
      }

      if (password.isNotEmpty) {
        // Update password if not blank
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(userId)
            .update({'password': password});
      }

      UserTest.userName = username;
      UserTest.email = email;

      // sharedPreferences.setString("userID", userRef.id);
      // sharedPreferences.setString("userRole", "user");
      //
      //
      //
      // UserTest.userID = userRef.id;
      // UserTest.role = "user";


      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text("User information updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text("Gagal melakukan pembaruan informasi")),
      );
    }
  }
}
