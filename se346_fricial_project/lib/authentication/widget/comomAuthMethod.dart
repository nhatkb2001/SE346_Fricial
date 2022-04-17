import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:se346_fricial_project/authentication/signupScreen.dart';
import 'package:se346_fricial_project/utils/colors.dart';

import '../signInScreen.dart';

Widget EmailTextFormField(
    {required String hintText,
    required String? Function(String?)? validator,
    required TextEditingController textEditingController,
    required Size size}) {
  return Container(
    margin: EdgeInsets.only(left: 32, right: 32),
    width: size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: AppColors.white,
    ),
    child: TextFormField(
      validator: validator,
      cursorColor: AppColors.grey1,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.grey1),
        border: InputBorder.none,
      ),
    ),
  );
}

Widget PasswordTextFormField(
    {required String hintText,
    required String? Function(String?)? validator,
    required TextEditingController textEditingController,
    required Size size}) {
  return Container(
    margin: EdgeInsets.only(left: 32, right: 32),
    width: size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: AppColors.white,
    ),
    child: TextFormField(
      validator: validator,
      cursorColor: AppColors.grey1,
      obscureText: true,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.grey1),
        border: InputBorder.none,
      ),
    ),
  );
}

Widget switchAnotherAuthScreen(
    BuildContext context, String buttonNameFirst, String buttonNameLast) {
  return ElevatedButton(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          buttonNameFirst,
          style: TextStyle(
            color: AppColors.grey2,
            fontSize: 16.0,
          ),
        ),
        Text(
          buttonNameLast,
          style: TextStyle(
            color: AppColors.red,
            fontSize: 16.0,
          ),
        ),
      ],
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0.0,
      primary: Colors.transparent,
    ),
    onPressed: () {
      if (buttonNameLast == "Sign up for free")
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SignUpScreen()),
        );
      else
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SignInScreen()),
        );
    },
  );
}

Widget RecoveryTextFormField(
    {required String hintText,
    required String? Function(String?)? validator,
    required TextEditingController textEditingController,
    required Size size}) {
  return Container(
    margin: EdgeInsets.only(left: 16, right: 16),
    width: size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.grey1,
    ),
    child: TextFormField(
      validator: validator,
      cursorColor: AppColors.white,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.white),
        border: InputBorder.none,
      ),
    ),
  );
}
