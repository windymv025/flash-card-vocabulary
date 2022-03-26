import 'package:flutter/material.dart';

const Color kPrimaryColor = Colors.blue;

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");


final defaultButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return Colors.blue.withOpacity(0.04);
        }
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed)) {
          return Colors.blue.withOpacity(0.12);
        }
        return null; // Defer to the widget's default.
      },
    ),
    foregroundColor: MaterialStateProperty.all(kPrimaryColor),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))));
