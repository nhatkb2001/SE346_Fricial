import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class onboardingScreen1 extends StatelessWidget {
  const onboardingScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(children: [
            SizedBox(
              height: 82,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_osdxlbqq.json'),
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              "Welcome to Fricial",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Text(
              "Instant communication platform for all \nyour team communication in one place.",
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
