import 'package:flutter/material.dart';
import '../constant.dart';

class ComponentFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final String? textBaru;
  final IconData? sideIcon;

  const ComponentFilledButton({
    required this.onPressed,
    this.onLongPress,
    this.textBaru,
    this.sideIcon,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textBaru ?? DefaultText.signIn,
            style: const TextStyle(
                color: Colors.white,
                fontSize: FontSizes.xl,
                fontStyle: FontStyle.normal,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(width: Margins.lg),
          sideIcon != null
              ? Icon(
            sideIcon,
            color: Colors.white,
            size: 24.0,
          )
              : SizedBox(), // Adjust the width as needed
        ],
    ));
  }
}
