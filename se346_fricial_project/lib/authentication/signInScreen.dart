import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se346_fricial_project/authentication/RecoveryPasswordScreen.dart';
import 'package:se346_fricial_project/authentication/widget/comomAuthMethod.dart';
import 'package:se346_fricial_project/utils/colors.dart';
import 'package:se346_fricial_project/utils/reg_exp.dart';
import 'package:se346_fricial_project/utils/utils.dart';
// ignore_for_file: prefer_const_constructors

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _logInKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  bool isHiddenPassword = true;

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
        body: Form(
          key: _logInKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/images/Login.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
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
                        "Welcome Back",
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
                        "login your account to access\nthe social network",
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
                        height: 182,
                        width: 160,
                        child: Image.asset('assets/images/signinImage.png'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  EmailTextFormField(
                      hintText: '  Email',
                      size: size,
                      textEditingController: this._email,
                      padding: 32.0),
                  SizedBox(
                    height: 16,
                  ),
                  PasswordTextFormField(
                    context: context,
                    hintText: '  Password',
                    validator: (String? inputVal) {
                      if (!passRegex.hasMatch(
                        inputVal.toString(),
                      )) {
                        showSnackBar(context,
                            'Password must be minimum eight characters, at least one letter and one number');
                      }
                      if (inputVal!.length < 6) {
                        showSnackBar(context,
                            'Conform Password must be at least 6 characters');
                      }
                      return null;
                    },
                    textEditingController: _pwd,
                    size: size,
                    isHiddenPassword: isHiddenPassword,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecoveryPasswordScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Forgot Password?",
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
                        Text(
                          " Click here",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: AppColors.red,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  logInAuthButton(context, 'sign In', size),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 85,
                        child: Divider(
                          color: AppColors.grey2,
                          thickness: 0.5,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Or continue with",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: AppColors.grey2,
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        width: 85,
                        child: Divider(
                          color: AppColors.grey2,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  socialMediaInterationButtons(),
                  SizedBox(height: 16),
                  switchAnotherAuthScreen(
                      context, 'Don’t have an account? ', 'Sign up for free'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logInAuthButton(BuildContext context, String buttonName, Size size) {
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
          if (this._logInKey.currentState!.validate()) {
            print('Validated');
          } else {
            print('Not Validated');
          }
        },
      ),
    );
  }

  Widget socialMediaInterationButtons() {
    return Container(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              print('Google Pressed');
            },
            child: Image.asset(
              'assets/images/google.png',
              width: 36.0,
              height: 36.0,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () async {
              print('Google Pressed');
            },
            child: Image.asset(
              'assets/images/fbook.png',
              width: 36.0,
              height: 36.0,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () async {
              print('Google Pressed');
            },
            child: Image.asset(
              'assets/images/apple.png',
              width: 36.0,
              height: 36.0,
            ),
          ),
        ],
      ),
    );
  }
}
