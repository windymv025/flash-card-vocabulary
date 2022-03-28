import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/assets.dart';
import 'socal_card.dart';

class ContinueWithComponent extends StatefulWidget {
  const ContinueWithComponent({Key? key}) : super(key: key);

  @override
  _ContinueWithComponentState createState() => _ContinueWithComponentState();
}

class _ContinueWithComponentState extends State<ContinueWithComponent> {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return Column(
    //   children: [
    //     const Center(
    //       child: Text(
    //         "Continue with",
    //         style: TextStyle(fontWeight: FontWeight.w600),
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         SocalCard(
    //           icon: Assets.assetsGoogleIcon,
    //           press: () async {
    //             final GoogleSignInAccount? googleUser =
    //                 await GoogleSignIn().signIn();

    //             // Obtain the auth details from the request
    //             final GoogleSignInAuthentication? googleAuth =
    //                 await googleUser?.authentication;

    //             // Create a new credential
    //             final credential = GoogleAuthProvider.credential(
    //               accessToken: googleAuth?.accessToken,
    //               idToken: googleAuth?.idToken,
    //             );

    //             // Once signed in, return the UserCredential
    //             await FirebaseAuth.instance.signInWithCredential(credential);
    //           },
    //         ),
    //         SocalCard(
    //           icon: Assets.assetsFacebook2,
    //           press: () {},
    //         ),
    //       ],
    //     )
    //   ],
    // );
  }
}
