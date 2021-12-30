import 'package:flutter/material.dart';
import 'package:flutter_cartest/src/app.dart';
import 'package:flutter_cartest/src/mixins/validation_mixin.dart';
import 'package:flutter_cartest/src/screens/live_video.dart';

const primaryColor = Color(0xFF1565C0);
const secondaryColor = Color(0xFF003C8F);
const additionalColor = Color(0xFFBBDEFB);

const labelColor = TextStyle(color: secondaryColor);

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 450),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              heading(),
              const SizedBox(height: 40),
              usernameField(),
              passwordField(),
              const SizedBox(height: 80),
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
    return Container(
      child: const Text(
        'WELCOME!',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 45, color: primaryColor),
      ),
    );
  }

  Widget usernameField() {
    return
        //
        TextFormField(
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.person,
          color: primaryColor,
        ),
        labelText: 'Username',
        labelStyle: labelColor,
        hintText: 'Your username',
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
    return Container(
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.lock,
            color: primaryColor,
          ),
          labelText: 'Password',
          labelStyle: labelColor,
          hintText: 'Your Password',
        ),
        validator: validatePassword,
        onSaved: (value) {
          if (value != null) {
            password = value;
          }
        },
      ),
    );
  }

  Widget submitButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          padding: MaterialStateProperty.all(EdgeInsets.all(20)),
        ),
        onPressed: () {
          if (formKey.currentState?.validate() == true) {
            formKey.currentState!.save();
            print('Time to post $username and $password to  my API');
          }
        },
        child: Text(
          'SIGN IN',
        ),
      ),
    );
  }

  Widget orSeparator() {
    return Container(
      padding: EdgeInsets.all(10),
      child: const Text(
        'or',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25, color: primaryColor),
      ),
    );
  }

  Widget livedemoButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(additionalColor),
          padding: MaterialStateProperty.all(EdgeInsets.all(20)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VideoPlayerApp()),
          );
        },
        child: Text(
          'LIVE DEMO',
        ),
      ),
    );
  }
}
