import 'package:flutter/material.dart';
import '../constant.dart';

class ComponentLoginHeader extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const ComponentLoginHeader({Key? key, required this.screenHeight, required this.screenWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Margins.xl),
      height: screenHeight / 3,
      width: screenWidth,
      // decoration: BoxDecoration(
      //   color: AppColors.primary,
      //   borderRadius: BorderRadius.all(Radius.circular(RadiusConstant.sm)),
      // ),
      child: Center(
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
