import 'package:flutter/material.dart';

class ComponentRichText extends StatelessWidget {
  final String text;
  final String clickableText;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final TextStyle clickableTextStyle;

  const ComponentRichText({
    required this.text,
    required this.clickableText,
    required this.onPressed,
    required this.textStyle,
    required this.clickableTextStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: RichText(
        text: TextSpan(
          text: text,
          style: textStyle,
          children: [
            TextSpan(
              text: clickableText,
              style: clickableTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
