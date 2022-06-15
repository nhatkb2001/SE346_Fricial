import 'package:email_validator/email_validator.dart';
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
    required String? Function(String?)? validator,
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
      validator: validator,
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
            color: AppColors.grey1,
          ),
        ),
        hintText: "Enter your Email",
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
        suffixIcon: InkWell(
            onTap: () {
              isHiddenPassword = !isHiddenPassword;
            },
            child: isHiddenPassword
                ? Stack(alignment: Alignment.centerRight, children: [
                    Container(
                        padding: EdgeInsets.only(right: 16),
                        child:
                            Icon(Iconsax.eye, size: 24, color: AppColors.grey1))
                  ])
                : Stack(alignment: Alignment.centerRight, children: [
                    Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(Iconsax.eye_slash,
                            size: 24, color: AppColors.grey1))
                  ])),
        contentPadding: EdgeInsets.only(left: 8, right: 8),
        hintStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          color: AppColors.grey1,
        ),
        hintText: "Enter your Password",
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
  return GestureDetector(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          buttonNameFirst,
          style: TextStyle(
            color: AppColors.white,
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
    onTap: () {
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

Widget InfomationTextFormField({
  required String hintText,
  required TextEditingController textEditingController,
  required Size size,
  required String? Function(String?)? validator,
}) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15),
    width: size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.grey1,
    ),
    child: TextFormField(
      cursorColor: AppColors.white,
      controller: textEditingController,
      keyboardType: TextInputType.emailAddress,
      autofillHints: [AutofillHints.email],
      validator: validator,
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
            color: AppColors.white,
          ),
        ),
        hintText: hintText,
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
