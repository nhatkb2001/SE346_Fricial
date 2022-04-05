import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore_for_file: prefer_const_constructors

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Text(
            'Sign in screen',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
