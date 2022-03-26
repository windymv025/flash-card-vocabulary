import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_card_app/constants/enums.dart';
import 'package:flutter/material.dart';

import '../sign_in/sign_in_screen.dart';
import 'components/learning_page_body.dart';

class LearningAllScren extends StatelessWidget {
  static const routeName = "/learning-all";
  const LearningAllScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SignInScreen();
          }
        return const Scaffold(
            body: LearningPageBody(
          type: TypeLearning.all,
        ));
      }
    );
  }
}
