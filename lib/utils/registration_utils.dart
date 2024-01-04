import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import 'navigation_utils.dart';

class RegistrationUtils {
  static Future<void> registerUser({
    required BuildContext context,
    required TextEditingController usernameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required String collectionName,
    required Widget successScreen,
    required Widget failureScreen,
  }) async {
    BuildContext currentContext = context;
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text("Username, Email, dan Password tidak boleh kosong!")),
      );
      return;
    }

    try {
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

      // Register the user if email is not already in use
      DocumentReference userRef = await FirebaseFirestore.instance.collection(collectionName).add({
        'userName': username,
        'email': email,
        'password': password,
        'role': 'karyawan'
        // Add other user data as needed
      });

      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      //
      // sharedPreferences.setString("userID", userRef.id);
      // sharedPreferences.setString("userRole", "user");
      // sharedPreferences.setString("userName", username);
      // sharedPreferences.setString("email", email);
      //
      // UserTest.userID = userRef.id;
      // UserTest.role = "user";
      // UserTest.userName = username;
      // UserTest.email = email;

      NavigationUtils.pushReplacement(
        currentContext,
        successScreen,
      );
    } catch (e) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text("Gagal melakukan registrasi")),
      );
    }
  }
}
