import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../constant.dart';

class ComponentSlideAction extends StatelessWidget {
  final GlobalKey<SlideActionState> slideActionKey;
  final String textIn;
  final String textOut;
  final bool isCheckIn;
  final bool isDisabled; // Added property for disabling
  final VoidCallback? onSlide;

  const ComponentSlideAction({
    Key? key,
    required this.slideActionKey,
    required this.textIn,
    required this.textOut,
    required this.isCheckIn,
    required this.isDisabled,
    this.onSlide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      text: isCheckIn ? textIn : textOut,
      enabled: isDisabled,
      textStyle: TextStyle(
        fontSize: FontSizes.md,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
        color: !isDisabled ? Colors.grey : Colors.white, // Change color if disabled
      ),
      outerColor: !isDisabled ? Colors.grey : AppColors.primary, // Change color if disabled
      key: slideActionKey,
      // enabled: !isDisabled, // Disable dragging if already checked in or out
      onSubmit: () {
        slideActionKey.currentState!.reset();
        if (onSlide != null) {
          onSlide!();
        }
      },
    );
    onSlide
    ;
  }
}
