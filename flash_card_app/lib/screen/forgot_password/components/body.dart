import 'package:flash_card_app/constants/assets.dart';
import 'package:flash_card_app/screen/widget/back_widget.dart';
import 'package:flutter/material.dart';

import '../../sign_in/components/no_account_text.dart';
import '../../widget/continue_with_component.dart';
import 'forgot_password_form.dart';

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 150,
                          child: Image.asset(Assets.assetsFlashCard)),
                      const ForgotPasswordForm(),
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
