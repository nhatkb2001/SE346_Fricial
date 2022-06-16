import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class onboardingScreen3 extends StatelessWidget {
  const onboardingScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Container(
          color: Color(0xFF202128),
          child: Column(children: [
            SizedBox(
              height: 80,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Lottie.network(
                  'https://assets9.lottiefiles.com/packages/lf20_zboivc9e.json'),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Stay Connect with your friends",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Text(
              "It's easy when you can chat,call and interact\n\t\t\t with your friends wherever you are",
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
