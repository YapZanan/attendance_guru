import 'package:flutter/material.dart';
import 'package:attendance_guru/constant.dart';
import 'package:attendance_guru/model/user_model.dart';

class ComponentUserInfo extends StatelessWidget {
  const ComponentUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(
        top: Margins.sm,
      ),
      child: Text(
        UserTest.userName,
        style: const TextStyle(
          fontSize: FontSizes.xl,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
    );
  }
}