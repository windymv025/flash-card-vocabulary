import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_card_app/constants/enums.dart';
import 'package:flash_card_app/screen/learning/components/learning_page_body.dart';
import 'package:flutter/material.dart';

import '../sign_in/sign_in_screen.dart';

class LearningFavoriteScreen extends StatefulWidget {
  static const routeName = "/learning-favorite";
  const LearningFavoriteScreen({Key? key}) : super(key: key);

  @override
  State<LearningFavoriteScreen> createState() => _LearningFavoriteScreenState();
}

class _LearningFavoriteScreenState extends State<LearningFavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SignInScreen();
          }
        return const Scaffold(
          body: SafeArea(child: LearningPageBody(type: TypeLearning.favorite)),
        );
      }
    );
  }
}
