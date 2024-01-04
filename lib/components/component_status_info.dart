// status_info.dart
import 'package:flutter/material.dart';
import 'package:attendance_guru/constant.dart';

class ComponentStatusInfo extends StatelessWidget {
  final String textTitle;

  const ComponentStatusInfo({
    Key? key,
    required this.textTitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(
        top: Margins.xl,
      ),
      child: Text(
        textTitle,
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