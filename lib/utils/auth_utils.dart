import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

        String combinedPassword = password + storedSalt;
        String enteredPasswordHash = hashPassword(combinedPassword);

        if (enteredPasswordHash == storedHashedPassword) {
          String idTemp = snap.docs[0].id;
          String roleTemp = snap.docs[0]['role'];
          String userNameTemp = snap.docs[0]['userName'];

          // Retrieve the photoURL from Firebase Storage
          String photoURL = await getPhotoURL(idTemp);

          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("userID", idTemp);
          sharedPreferences.setString("userRole", roleTemp);
          sharedPreferences.setString("userName", userNameTemp);
          sharedPreferences.setString("email", email);
          sharedPreferences.setString("photoURL", photoURL);

          UserTest.userID = idTemp.toString();
          UserTest.role = roleTemp.toString();
          UserTest.userName = userNameTemp.toString();
          UserTest.email = email.toString();
          UserTest.photoURL = photoURL;

          if (roleTemp == "admin" || roleTemp == "karyawan") {
            NavigationUtils.pushReplacement(
              currentContext,
              (roleTemp == "admin") ? adminScreen : userScreen,
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

  static Future<String> getPhotoURL(String userId) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('$userId/default_profile.jpg');
      String downloadURL = await storageReference.getDownloadURL();
      print(downloadURL);
      return downloadURL;
    } catch (e) {
      print("Error fetching photoURL: $e");
      return 'https://firebasestorage.googleapis.com/v0/b/presensiguru-41ee9.appspot.com/o/default_profile.jpg?alt=media&token=fe42f0b2-00f7-4aef-8dfa-0b0c36c16a1a';
    }
  }

  static String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
