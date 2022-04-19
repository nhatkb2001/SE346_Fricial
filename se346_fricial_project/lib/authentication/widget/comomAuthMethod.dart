import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:se346_fricial_project/authentication/signupScreen.dart';
import 'package:se346_fricial_project/utils/colors.dart';

import '../signInScreen.dart';

Widget EmailTextFormField(
    {required String hintText,
    required TextEditingController textEditingController,
    required Size size,
    required double padding}) {
  return Container(
    margin: EdgeInsets.only(left: 32, right: 32),
    width: size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: AppColors.white,
    ),
    child: TextFormField(
      cursorColor: AppColors.grey1,
      controller: textEditingController,
      keyboardType: TextInputType.emailAddress,
      autofillHints: [AutofillHints.email],
      // decoration: InputDecoration(
      //   hintText: hintText,
      //   hintStyle: TextStyle(color: AppColors.grey1),
      //   border: InputBorder.none,
      // ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 8, right: 8),
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.white1.withOpacity(0.5),
          ),
        ),
        hintText: "Enter your email",
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 0,
          height: 0,
        ),
      ),
    ),
  );
}

Widget PasswordTextFormField({
  required BuildContext context,
  required String hintText,
  required String? Function(String?)? validator,
  required TextEditingController textEditingController,
  required Size size,
  required bool isHiddenPassword,
}) {
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
      obscureText: isHiddenPassword,
      keyboardType: TextInputType.visiblePassword,
      autofillHints: [AutofillHints.password],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 8, right: 8),
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.white1.withOpacity(0.5),
        ),
        hintText: "Enter your password",
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 0,
          height: 0,
        ),
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
