import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_card_app/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../widget/default_button.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          DefaultButton(
            text: "Submit",
            press: _submit,
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {},
      validator: (value) {
        if (value!.isEmpty || !emailValidatorRegExp.hasMatch(value)) {
          return "Please enter a valid email address";
        }
        return null;
      },
      onFieldSubmitted: (value) => _submit(),
      decoration: const InputDecoration(
        label: Text("Email"),
      ),
    );
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // if all are valid then go to success screen
      FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    }
  }
}
