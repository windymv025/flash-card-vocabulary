import 'package:flutter/material.dart';

import 'components/signin_body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  SigninBody(),

    );
  }
}
