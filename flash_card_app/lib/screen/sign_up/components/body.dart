import 'package:flutter/material.dart';

import '../../../constants/assets.dart';
import '../../widget/back_widget.dart';
import '../../widget/continue_with_component.dart';
import 'already_have_account.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const BackWidget(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 120,
                          child: Image.asset(Assets.assetsFlashCard)),
                      const SizedBox(
                        height: 25,
                      ),
                      const SignUpForm(),
                      const SizedBox(
                        height: 15,
                      ),
                      const ContinueWithComponent(),
                      const SizedBox(
                        height: 10,
                      ),
                      const AlreadyHaveAccount(),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
