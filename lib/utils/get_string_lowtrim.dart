import 'package:flutter/cupertino.dart';

class GetStringLowTrim {
  static String getEmail(TextEditingController controller) {
    return controller.text.trim().toLowerCase();
  }
}