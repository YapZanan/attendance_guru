import 'package:flutter/material.dart';

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