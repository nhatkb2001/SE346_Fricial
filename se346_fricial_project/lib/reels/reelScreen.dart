import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

///add constants
import 'package:se346_fricial_project/constants/colors.dart';
import 'package:se346_fricial_project/constants/fonts.dart';
import 'package:se346_fricial_project/dashboard/dashboardScreen.dart';
import 'package:se346_fricial_project/utils/loading_widget.dart';

class atReelScreen extends StatefulWidget {
  @override
  _atReelScreen createState() => _atReelScreen();
}

class _atReelScreen extends State<atReelScreen>
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
      body: Column(
        children: [
          Container(
            color: white,
            child: Text(
              'Reels',
              style: TextStyle(fontSize: 50, color: black),
            ),
          ),
          LoadingWidget(),
        ],
      ),
    );
  }
}
