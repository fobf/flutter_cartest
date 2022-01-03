// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:flutter_cartest/src/mixins/validation_mixin.dart';
import 'package:flutter_cartest/src/screens/live_video.dart';
import 'package:flutter_cartest/const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  late String username = '';
  late String password = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: kmarginLoginScreen,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: kspacer150),
              heading(),
              const SizedBox(height: kspacer50),
              usernameField(),
              passwordField(),
              const SizedBox(height: kspacer100),
              submitButton(),
              orSeparator(),
              livedemoButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget heading() {
    return const Text(
      kwelcomeText,
      style: kheaderStyle,
    );
  }

  Widget usernameField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.person,
          size: kiconSize,
          color: kprimaryColor,
        ),
        labelText: 'Username',
        labelStyle: klabelStyle,
        hintText: 'Your username',
        alignLabelWithHint: true,
      ),
      validator: validateUsername,
      onSaved: (value) {
        if (value != null) {
          username = value;
        }
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.lock,
          size: kiconSize,
          color: kprimaryColor,
        ),
        labelText: 'Password',
        alignLabelWithHint: true,
        labelStyle: klabelStyle,
        hintText: 'Your Password',
      ),
      validator: validatePassword,
      onSaved: (value) {
        if (value != null) {
          password = value;
        }
      },
    );
  }

  Widget submitButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kprimaryColor),
          padding: MaterialStateProperty.all(kButtonPadding),
        ),
        onPressed: () {
          if (formKey.currentState?.validate() == true) {
            formKey.currentState!.save();
            print('Time to post $username and $password to  my API');
          }
        },
        child: const Text(
          kSignInText,
        ),
      ),
    );
  }

  Widget orSeparator() {
    return Container(
      padding: kButtonPadding,
      child: const Text(
        kOrText,
        style: TextStyle(color: kprimaryColor, fontSize: 25),
      ),
    );
  }

  Widget livedemoButton() {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kadditionalColor),
          padding: MaterialStateProperty.all(kButtonPadding),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VideoPlayerScreen()),
          );
        },
        child: const Text(
          kLiveDemoText,
        ),
      ),
    );
  }
}
