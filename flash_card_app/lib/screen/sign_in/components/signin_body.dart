import 'package:flash_card_app/screen/sign_in/components/sign_in_form.dart';
import 'package:flash_card_app/screen/widget/back_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/assets.dart';
import '../../widget/continue_with_component.dart';
import 'no_account_text.dart';

class SigninBody extends StatelessWidget {
  const SigninBody({Key? key}) : super(key: key);

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
                          height: 150,
                          child: Image.asset(Assets.assetsFlashCard)),
                      const SizedBox(
                        height: 25,
                      ),
                      const SignInForm(),
                      const SizedBox(
                        height: 15,
                      ),
                      const ContinueWithComponent(),
                      const SizedBox(
                        height: 10,
                      ),
                      const NoAccountText(),
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
