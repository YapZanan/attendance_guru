import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import 'navigation_utils.dart';

class AuthUtils {
  static Future<void> loginUser({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required String collectionName,
    required Widget adminScreen,
    required Widget userScreen,
  }) async {
    BuildContext currentContext = context;
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text("Email atau Password tidak boleh kosong!")),
      );
      return;
    }

    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection(collectionName)
          .where('email', isEqualTo: email)
          .get();

      if (snap.docs.isNotEmpty) {
        String storedHashedPassword = snap.docs[0]['password'];
        String storedSalt = snap.docs[0]['salt'];

        // Combine entered password with stored salt
        String combinedPassword = password + storedSalt;

        // Hash the combined password and salt
        String enteredPasswordHash = hashPassword(combinedPassword);

        // Compare the hashes
        if (enteredPasswordHash == storedHashedPassword) {
          String idTemp = snap.docs[0].id;
          String roleTemp = snap.docs[0]['role'];
          String userNameTemp = snap.docs[0]['userName'];

          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("userID", idTemp);
          sharedPreferences.setString("userRole", roleTemp);
          sharedPreferences.setString("userName", userNameTemp);
          sharedPreferences.setString("email", email);

          UserTest.userID = idTemp.toString();
          UserTest.role = roleTemp.toString();
          UserTest.userName = userNameTemp.toString();
          UserTest.email = email.toString();

          if (roleTemp == "admin") {
            NavigationUtils.pushReplacement(
              currentContext,
              adminScreen,
            );
          } else if (roleTemp == "karyawan") {
            NavigationUtils.pushReplacement(
              currentContext,
              userScreen,
            );
          }
        } else {
          ScaffoldMessenger.of(currentContext).showSnackBar(
            const SnackBar(content: Text("Email atau Password salah")),
          );
        }
      } else {
        ScaffoldMessenger.of(currentContext).showSnackBar(
          const SnackBar(content: Text("Email atau Password salah")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text("Email atau Password salah")),
      );
    }
  }

  // Function to hash the password using SHA-256
  static String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
