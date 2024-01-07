import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
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

      String salt = generateSalt();

      // Hash the password with the salt using SHA-256
      String hashedPassword = hashPassword(password, salt);

      // Register the user if email is not already in use
      DocumentReference userRef = await FirebaseFirestore.instance.collection(collectionName).add({
        'userName': username,
        'email': email,
        'password': hashedPassword,
        'salt': salt,  // <-- Store the salt
        'role': 'karyawan',
        'photoURL': 'https://firebasestorage.googleapis.com/v0/b/presensiguru-41ee9.appspot.com/o/default_profile.jpg?alt=media&token=fe42f0b2-00f7-4aef-8dfa-0b0c36c16a1a',
        // Add other user data as needed
      });

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

  static String generateSalt() {
    final random = Random.secure();
    final List<int> saltBytes = List.generate(16, (index) => random.nextInt(255));
    return base64UrlEncode(saltBytes);
  }

  // Function to hash the password with the salt using SHA-256
  static String hashPassword(String password, String salt) {
    var bytes = utf8.encode(password + salt);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
