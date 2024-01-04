import 'package:attendance_guru/screens/admin/admin_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/component_navbar.dart';
import '../../constant.dart';
class AdminSetJamScreen extends StatefulWidget {
  const AdminSetJamScreen({super.key});

  @override
  State<AdminSetJamScreen> createState() => _AdminSetJamScreenState();
}

class _AdminSetJamScreenState extends State<AdminSetJamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
            },
            child: const Text(
                "LogOut"
            )),
      ),
    );
  }
}