import 'package:flutter/material.dart';

import '../../sign_in/sign_in_screen.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, SignInScreen.routeName);
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
                color: Color(0xff248EEF),
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
