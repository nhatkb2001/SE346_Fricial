import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:se346_fricial_project/authentication/RecoveryPasswordScreen.dart';
import 'package:se346_fricial_project/authentication/widget/comomAuthMethod.dart';
import 'package:se346_fricial_project/dashboard/dashboardScreen.dart';
import 'package:se346_fricial_project/navigationBar/navigationBar.dart';
import 'package:se346_fricial_project/resources/sign_up_auth.dart';
import 'package:se346_fricial_project/utils/colors.dart';
import 'package:se346_fricial_project/utils/loading_widget.dart';
import 'package:se346_fricial_project/utils/reg_exp.dart';
import 'package:se346_fricial_project/utils/utils.dart';

import '../profile/editProfileScreen.dart';
import '../utils/enum_generation.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _logInKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();
  bool isHiddenPassword = true;
  bool _isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

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
            child: _isLoading
                ? LoadingWidget()
                : Container(
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
                              "Login your account to access\nthe social network",
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
                              child:
                                  Image.asset('assets/images/signinImage.png'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        EmailTextFormField(
                            hintText: '  Email',
                            size: size,
                            validator: (String? inputVal) {
                              if (!emailRegex.hasMatch(inputVal.toString())) {
                                showSnackBar(
                                    context, 'Email format is not matching');
                                return '';
                              }

                              return null;
                            },
                            textEditingController: this._email,
                            padding: 32.0),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 32, right: 32),
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.white,
                          ),
                          alignment: Alignment.topCenter,
                          child: TextFormField(
                              style: TextStyle(
                                  fontFamily: 'SFProText',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              controller: _pwd,
                              obscureText: isHiddenPassword,
                              keyboardType: TextInputType.visiblePassword,
                              autofillHints: [AutofillHints.password],
                              validator: (inputVal) {
                                if (inputVal!.length < 6) {
                                  showSnackBar(context,
                                      'Password must be at least 6 characters');
                                  return '';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isHiddenPassword = !isHiddenPassword;
                                      });
                                    },
                                    child: isHiddenPassword
                                        ? Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        right: 20),
                                                    child: Icon(Iconsax.eye,
                                                        size: 24,
                                                        color: Colors.grey))
                                              ])
                                        : Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        right: 20),
                                                    child: Icon(
                                                        Iconsax.eye_slash,
                                                        size: 24,
                                                        color: Colors.grey))
                                              ])),
                                contentPadding:
                                    EdgeInsets.only(left: 8, right: 8),
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
                              )),
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
                        logInAuthButton(context, 'Sign In', size),
                        SizedBox(
                          height: 24,
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
                              width: 24,
                            ),
                            Text(
                              "or continue with",
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
                              width: 24,
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
                        SizedBox(height: 32),
                        socialMediaInterationButtons(),
                        SizedBox(height: 32),
                        switchAnotherAuthScreen(context,
                            'Don’t have an account? ', 'Sign up for free'),
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
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: () async {
          if (this._logInKey.currentState!.validate()) {
            print('Validated');
            SystemChannels.textInput.invokeMethod('TextInput.hide');

            if (mounted) {
              setState(() {
                this._isLoading = true;
              });
            }

            final EmailSignInResults emailSignInResults =
                await _emailAndPasswordAuth.signInWithEmailAndPassword(
                    email: this._email.text, pwd: this._pwd.text);

            String msg = '';
            if (emailSignInResults == EmailSignInResults.SignInCompleted) {
              final User? user = auth.currentUser;
              final uid = user?.uid;
              if (uid != null) {
                await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => navigationBar(uid: uid)),
                    (route) => false);
              }
            } else if (emailSignInResults ==
                EmailSignInResults.EmailNotVerified) {
              msg =
                  'Email not Verified.\nPlease Verify your email and then Log In';
            } else if (emailSignInResults ==
                EmailSignInResults.EmailOrPasswordInvalid)
              msg = 'Email And Password Invalid';
            else
              msg = 'Sign In Not Completed';

            if (msg != '')
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(msg)));

            if (mounted) {
              setState(() {
                this._isLoading = false;
              });
            }
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
