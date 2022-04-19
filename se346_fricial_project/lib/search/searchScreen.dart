import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

///add constants
import 'package:se346_fricial_project/constants/colors.dart';
import 'package:se346_fricial_project/constants/fonts.dart';
import 'package:se346_fricial_project/dashboard/dashboardScreen.dart';

class atSearchScreen extends StatefulWidget {
  @override
  _atSearchScreen createState() => _atSearchScreen();
}

class _atSearchScreen extends State<atSearchScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: white,
        child: Text(
          'Searching',
          style: TextStyle(fontSize: 50, color: black),
        ),
      ),
    );
  }
}