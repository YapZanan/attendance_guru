import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/navigation_utils.dart';
import '../../main.dart';

class LogOut {
  static Future<void> performLogOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("userID");
    sharedPreferences.remove("userRole");
    sharedPreferences.remove("userName");
    sharedPreferences.remove("email");

    NavigationUtils.pushReplacement(context, const MyApp());
  }
}
