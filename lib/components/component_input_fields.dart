import 'package:flutter/material.dart';
import '../constant.dart';

class ComponentInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final double screenWidth;
  final bool obscureText;
  final bool showEyeButton;
  final Function(bool) onToggleVisibility;
  final TextEditingController controller;

  const ComponentInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.screenWidth,
    required this.obscureText,
    required this.showEyeButton,
    required this.onToggleVisibility,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Margins.sm),
      width: screenWidth,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.5,
            color: AppColors.accent,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: ImageSize.xl,
          ),
          const SizedBox(width: Margins.sm), // Add some spacing
          Expanded(
            child: TextFormField(
              enableSuggestions: true,
              autocorrect: false,
              obscureText: obscureText,
              controller: controller,
              style: const TextStyle(
                fontSize: FontSizes.md,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: AppColors.text,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: Margins.sm,
                  horizontal: Margins.md,
                ),
                border: InputBorder.none,
                hintText: hintText,
                suffixIcon: showEyeButton ? buildEyeIcon() : null,
                // Set the alignment of suffixIcon to center
                suffixIconConstraints: const BoxConstraints.tightFor(height: 24.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconButton buildEyeIcon() {
    return IconButton(
      icon: Icon(
        obscureText ? Icons.visibility : Icons.visibility_off,
        color: AppColors.primary,
      ),
      onPressed: () {
        onToggleVisibility(!obscureText);
      },
    );
  }
}