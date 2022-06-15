import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:se346_fricial_project/authentication/signInScreen.dart';
import 'package:se346_fricial_project/dashboard/dashboardScreen.dart';
import 'package:se346_fricial_project/navigationBar/navigationBar.dart';
import 'package:se346_fricial_project/resources/cloud_data_management.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboardings/onboardingWrapper.dart';

int initScreen = 0;

Future<void> main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = (preferences.getInt('initScreen') ?? 0);
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fresh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        primarySwatch: Colors.grey,
        cardColor: Colors.white70,
        accentColor: Colors.white,
      ),
      initialRoute: initScreen == 0 ? 'onboarding' : 'signin',
      routes: {
        'onboarding': (context) => onboardingWrapper(),
        'signin': (context) => SignInScreen(),
      },
    );
  }
}
