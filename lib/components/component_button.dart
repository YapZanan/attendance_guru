import 'package:flutter/material.dart';
import '../constant.dart';

class ComponentFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;

  const ComponentFilledButton({
    required this.onPressed,
    this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.accent,
        backgroundColor: AppColors.primary,
        minimumSize: const Size(double.maxFinite, 50),
      ),
      child: const Text(
        DefaultText.signIn,
        style: TextStyle(
          color: Colors.white,
          fontSize: FontSizes.xl,
          fontStyle: FontStyle.normal,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600
        ),
        ),
    );
  }
}
