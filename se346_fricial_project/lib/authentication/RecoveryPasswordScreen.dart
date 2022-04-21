import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:se346_fricial_project/authentication/widget/comomAuthMethod.dart';
import 'package:se346_fricial_project/utils/colors.dart';

import '../utils/reg_exp.dart';
import '../utils/utils.dart';

class RecoveryPasswordScreen extends StatefulWidget {
  RecoveryPasswordScreen({Key? key}) : super(key: key);

  @override
  State<RecoveryPasswordScreen> createState() => _RecoveryPasswordScreenState();
}

class _RecoveryPasswordScreenState extends State<RecoveryPasswordScreen> {
  final GlobalKey<FormState> _recoveryKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
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
          key: _recoveryKey,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ChangePassword.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Iconsax.back_square,
                            color: AppColors.white2,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Recovery Password",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: AppColors.white2,
                                fontSize: 24,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Lottie.network(
                      'https://assets6.lottiefiles.com/packages/lf20_dneo0c5x.json',
                      width: 240,
                      height: 240),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    Text(
                      "Email",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
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
                EmailTextFormField(
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? showSnackBar(context, 'Enter a valid email')
                            : null,
                    hintText: '  Enter your current email',
                    size: size,
                    textEditingController: this._email,
                    padding: 16.0),
                SizedBox(
                  height: 32,
                ),
                ConFirmButton(context, 'Confirm', size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ConFirmButton(BuildContext context, String buttonName, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 122, right: 122),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size.width, 32.0),
          elevation: 5.0,
          primary: AppColors.white1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        child: Text(
          buttonName,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        onPressed: () async {
          if (this._recoveryKey.currentState!.validate()) {
            print('Validated');
          } else {
            print('Not Validated');
          }
        },
      ),
    );
  }
}
