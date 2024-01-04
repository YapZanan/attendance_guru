import 'package:attendance_guru/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';
import '../../utils/navigation_utils.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.remove("userID");
              sharedPreferences.remove("userRole");
              sharedPreferences.remove("userName");
              sharedPreferences.remove("email");

              NavigationUtils.pushReplacement(
                  context, const MyApp());
            },
            child: const Text(
              "LogOut"
            )),
      ),
    );
  }
}