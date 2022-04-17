import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se346_fricial_project/authentication/widget/comomAuthMethod.dart';
import 'package:se346_fricial_project/utils/colors.dart';

import '../utils/reg_exp.dart';
import '../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _name = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _signUpKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 64,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 48,
                    ),
                    Text(
                      "Create Account",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 48,
                    ),
                    Text(
                      "Register your new account to\naccess the social network",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 178,
                      width: 200,
                      child: Image.asset('assets/images/signup.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 33,
                ),
                EmailTextFormField(
                  hintText: '  Full Name',
                  size: size,
                  validator: (String? inputVal) {
                    if (inputVal!.length < 6) {
                      showSnackBar(
                          context, 'Full Name must be at least 6 characters');
                    }
                    return null;
                  },
                  textEditingController: this._name,
                ),
                SizedBox(
                  height: 16,
                ),
                EmailTextFormField(
                  hintText: '  Email',
                  size: size,
                  validator: (String? inputVal) {
                    if (!emailRegex.hasMatch(inputVal.toString())) {
                      showSnackBar(context, 'Email format is not matching');
                    }

                    return null;
                  },
                  textEditingController: this._email,
                ),
                SizedBox(
                  height: 16,
                ),
                PasswordTextFormField(
                  hintText: '  Password',
                  validator: (String? inputVal) {
                    if (!passRegex.hasMatch(
                      inputVal.toString(),
                    ))
                      showSnackBar(context,
                          'Password must be minimum eight characters, at least one letter and one number');
                    return null;
                  },
                  textEditingController: _pwd,
                  size: size,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    CustomCheckBox(),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "I agree to the ",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    Text(
                      "Terms and Conditions",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColors.red,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                SignUpAuthButton(context, 'Sign up', size),
                switchAnotherAuthScreen(
                    context, 'Already have an account?', ' Sign In'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomCheckBox() {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isChecked = !isChecked;
          });
        },
        child: AnimatedContainer(
          height: 16,
          width: 16,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: isChecked ? AppColors.red : Colors.white,
            border: Border.all(color: AppColors.black),
          ),
          child: isChecked
              ? Icon(
                  Icons.check,
                  color: AppColors.black2,
                  size: 12,
                )
              : null,
        ),
      ),
    );
  }

  Widget SignUpAuthButton(BuildContext context, String buttonName, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 80, right: 80),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size.width, 47.0),
          elevation: 5.0,
          primary: AppColors.white1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
          ),
        ),
        child: Text(
          buttonName,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: AppColors.black1,
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: () async {
          if (this._signUpKey.currentState!.validate()) {
            print('Validated');
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          } else {
            print('Not Validated');
          }
        },
      ),
    );
  }
}
