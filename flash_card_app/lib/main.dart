import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_card_app/screen/forgot_password/forgot_password_screen.dart';
import 'package:flash_card_app/screen/home/home_screen.dart';
import 'package:flash_card_app/screen/learning/learing_favorite_screen.dart';
import 'package:flash_card_app/screen/learning/learning_all_screen.dart';
import 'package:flash_card_app/screen/learning/learning_forgotten_screen.dart';
import 'package:flash_card_app/screen/sign_in/sign_in_screen.dart';
import 'package:flash_card_app/screen/sign_up/sign_up_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constants/firebase_config.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
  await Firebase.initializeApp(options: firebaseOptions);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            }

            return const SignInScreen();
          }),
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        LearningAllScren.routeName: (context) => const LearningAllScren(),
        LearningFavoriteScreen.routeName: (context) =>
            const LearningFavoriteScreen(),
        LearningForgottenScreen.routeName: (context) =>
            const LearningForgottenScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        ForgotPasswordScreen.routeName: (context) =>
            const ForgotPasswordScreen(),
      },
    );
  }
}
