import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_card_app/screen/learning/learing_favorite_screen.dart';
import 'package:flash_card_app/screen/learning/learning_all_screen.dart';
import 'package:flutter/material.dart';

import '../learning/learning_forgotten_screen.dart';

class MenuTabWidget extends StatelessWidget {
  const MenuTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: const Color.fromARGB(255, 8, 138, 3),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, LearningAllScren.routeName);
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    "Learning All",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            color: Colors.blue,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, LearningForgottenScreen.routeName);
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    "Forgottenly",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            color: Colors.red,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, LearningFavoriteScreen.routeName);
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    "Favorite",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
          child: const Icon(
            Icons.logout_rounded,
          ),
        )
      ],
    );
  }
}
