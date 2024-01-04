import 'package:flutter/material.dart';
import '../constant.dart';

class ComponentFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final String? textBaru;

  const ComponentFilledButton({
    required this.onPressed,
    this.onLongPress,
    this.textBaru,
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
      child: Text(
        textBaru ?? DefaultText.signIn,
        style: const TextStyle(
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
