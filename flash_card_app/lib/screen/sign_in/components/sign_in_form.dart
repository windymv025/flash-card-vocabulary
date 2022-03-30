import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../home/home_screen.dart';
import '../../widget/default_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  bool isLoading = false;

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
          buildPasswordFormField(),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, ForgotPasswordScreen.routeName),
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Color(0xff248EEF),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          isLoading
              ? CircularProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                  backgroundColor: Colors.grey[200],
                )
              : DefaultButton(
                  text: "Sign In",
                  press: _signIn,
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
      textInputAction: TextInputAction.next,
      initialValue: email,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        checkEmail(value);
      },
      validator: (value) {
        return value == null ? null : checkEmail(value);
      },
      decoration: const InputDecoration(
        label: Text("Email"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      initialValue: password,
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        checkPassword(value);
      },
      validator: (value) {
        return value == null ? null : checkPassword(value);
      },
      onFieldSubmitted: (value) => _signIn(),
      decoration: const InputDecoration(
        label: Text("Password"),
      ),
    );
  }

  String? checkEmail(String value) {
    if (value.isEmpty) {
      return ("Please enter a valid email address");
    }
    if (!emailValidatorRegExp.hasMatch(value)) {
      return ("Please enter a valid email address");
    }
    return null;
  }

  String? checkPassword(String value) {
    if (value.isEmpty) {
      return ("Please enter a password");
    }

    return null;
  }

  void _singAccount() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value.user != null) {
        Navigator.restorablePushReplacementNamed(context, HomeScreen.routeName);
      }
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      print(error);
    });
  }

  _signIn() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState!.save();
      _singAccount();
    }
  }
}
