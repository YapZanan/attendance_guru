import 'package:flutter/material.dart';
import 'package:attendance_guru/constant.dart';

class ComponentTimeDisplay extends StatelessWidget {
  final Stream<String> timeStream;

  const ComponentTimeDisplay({Key? key, required this.timeStream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: timeStream,
      builder: (context, snapshot) {
        return Text(
          snapshot.data ?? '', // Display the current time
          style: const TextStyle(
            fontSize: FontSizes.md,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            color: AppColors.text,
          ),
        );
      },
    );
  }
}