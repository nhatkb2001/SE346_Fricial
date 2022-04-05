import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../authentication/signInScreen.dart';
import 'onboardingScreen1.dart';
import 'onboardingScreen2.dart';
import 'onboardingScreen3.dart';
import 'onboardingScreen4.dart';

class onboardingWrapper extends StatefulWidget {
  onboardingWrapper({Key? key}) : super(key: key);

  @override
  State<onboardingWrapper> createState() => _onboardingWrapperState();
}

class _onboardingWrapperState extends State<onboardingWrapper> {
  final controller = LiquidController();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            LiquidSwipe(
              liquidController: controller,
              waveType: WaveType.liquidReveal,
              enableSideReveal: true,
              onPageChangeCallback: (index) {
                setState(() {});
              },
              slideIconWidget: const Icon(
                Iconsax.arrow_left_35,
                color: Colors.black,
              ),
              pages: [
                onboardingScreen1(),
                onboardingScreen2(),
                onboardingScreen3(),
                onboardingScreen4(),
              ],
            ),
            Positioned(
              bottom: 32,
              left: 16,
              right: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('SKIP'),
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: controller.currentPage,
                    count: 4,
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 16,
                      dotColor: Color(0xFF888888),
                      activeDotColor: Colors.black,
                    ),
                    onDotClicked: (index) {
                      controller.animateToPage(page: index);
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      final page = controller.currentPage + 1;
                      page == 4
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            )
                          : controller.animateToPage(
                              page: page > 4 ? 0 : page, duration: 400);
                    },
                    child: const Text('NEXT'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
