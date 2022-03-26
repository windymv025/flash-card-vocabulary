import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_card_app/screen/home/home_body.dart';
import 'package:flutter/material.dart';

import '../sign_in/sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SignInScreen();
          }
          return const Scaffold(
            body: HomeBody(),
          );
        });
  }
}
