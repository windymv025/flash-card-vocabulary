import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../widget/default_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  List<String> errors = [];

  String? conformPassword;
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
          const SizedBox(height: 25),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                        context, ForgotPasswordScreen.routeName);
                  },
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
                  text: "Sign Up",
                  press: _signUp,
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
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        email = value;
        checkEmail(value);
      },
      validator: (value) {
        return value == null ? "" : checkEmail(value);
      },
      decoration: const InputDecoration(
        label: Text("Email"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        password = value;
        checkPassword(value);
      },
      validator: (value) {
        return value == null ? "" : checkPassword(value);
      },
      onFieldSubmitted: (value) => _signUp(),
      decoration: const InputDecoration(
        label: Text("Password"),
      ),
    );
  }

  String? checkEmail(String value) {
    if (value.isEmpty) {
      return "Please enter your email";
    }
    if (!emailValidatorRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? checkPassword(String value) {
    if (value.isEmpty) {
      return "Please enter a valid password";
    }
    return null;
  }

  void _signUpAccount() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      if (value.user != null) {
        FirebaseDatabase.instance.ref("users").child(value.user!.uid).set({
          "numberOfVocabulary": 0,
          "numberOfRemember": 0,
        });
      }
      Navigator.pop(context);
    }).catchError((error) {
      print(error);
    });
  }

  _signUp() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // if all are valid then go to success screen
      setState(() {
        isLoading = true;
      });
      _signUpAccount();
    }
  }
}
