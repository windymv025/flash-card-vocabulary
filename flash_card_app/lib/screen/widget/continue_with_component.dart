import 'package:flutter/material.dart';

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
    //           press: () {

    //           },
    //         ),
    //         SocalCard(
    //           icon: Assets.assetsFacebook2,
    //           press: () {

    //           },
    //         ),
    //       ],
    //     )
    //   ],
    // );
  }
}
