// status_info.dart
import 'package:flutter/material.dart';
import 'package:attendance_guru/constant.dart';

class StatusInfo extends StatelessWidget {
  const StatusInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(
        top: Margins.xl,
      ),
      child: const Text(
        "Status Hari Ini:",
        style: TextStyle(
          fontSize: FontSizes.xl,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
    );
  }
}