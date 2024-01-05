import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

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
      if (username.isEmpty && password.isEmpty && email.isEmpty) {
        ScaffoldMessenger.of(currentContext).showSnackBar(
          const SnackBar(
            content: Text("Isi salah satu", textAlign: TextAlign.center),
          ),
        );
        return;
      }

      // Update username if not blank
      if (username.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(userId)
            .update({'userName': username});
        sharedPreferences.setString("userName", username);
      }

      // Update email if not blank
      if (email.isNotEmpty) {
        // Check if the new email is not already in use
        QuerySnapshot snap = await FirebaseFirestore.instance
            .collection(collectionName)
            .where('email', isEqualTo: email)
            .get();

        if (snap.docs.isNotEmpty) {
          ScaffoldMessenger.of(currentContext).showSnackBar(
            const SnackBar(
              content: Text("Email sudah digunakan", textAlign: TextAlign.center),
            ),
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

      // Update password if not blank
      if (password.isNotEmpty) {
        String newSalt = generateSalt();
        String newHashedPassword = hashPassword(password, newSalt);

        // Update salt and hashed password in the Firestore document
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(userId)
            .update({
          'salt': newSalt,
          'password': newHashedPassword,
        });
      }

      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(
          content: Text("User information updated successfully", textAlign: TextAlign.center),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(
          content: Text("Gagal melakukan pembaruan informasi", textAlign: TextAlign.center),
        ),
      );
    }
  }

  // Function to generate a random salt
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
