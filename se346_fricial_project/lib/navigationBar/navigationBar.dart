import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';

///add constants
import 'package:se346_fricial_project/constants/colors.dart';
import 'package:se346_fricial_project/dashboard/dashboardScreen.dart';
import 'package:se346_fricial_project/models/user.dart';
import 'package:se346_fricial_project/notification/notificationScreen.dart';
import 'package:se346_fricial_project/profile/profileScreen.dart';
import 'package:se346_fricial_project/reels/reel.dart';
import 'package:se346_fricial_project/search/searching.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';

class navigationBar extends StatefulWidget {
  String uid;
  navigationBar({Key? key, required this.uid}) : super(key: key);
  @override
  _navigationBar createState() => _navigationBar(this.uid);
}

class _navigationBar extends State<navigationBar>
    with TickerProviderStateMixin {
  String uid = '';
  TabController? _tabController;
  var userData = {};
  bool isLoading = false;

  _navigationBar(this.uid);
  late userModel user = userModel(
      avatar: '',
      background: '',
      email: '',
      favoriteList: [],
      fullName: '',
      id: '',
      phoneNumber: '',
      saveList: [],
      state: '',
      userName: '',
      follow: [],
      role: '',
      gender: '',
      dob: '');

  Future getUserDetail() async {
    FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: uid)
        .snapshots()
        .listen((value) {
      setState(() {
        user = userModel.fromDocument(value.docs.first.data());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    User? user = FirebaseAuth.instance.currentUser;
    final userid = user?.uid.toString();
    uid = userid!;
    _tabController = TabController(length: 5, vsync: this);
    getUserDetail();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: <Widget>[
          atDashboardScreen(
            required,
            uid: uid,
          ),
          atSearchScreen(
            required,
            uid: uid,
          ),
          atReelScreen(
            required,
            uid: uid,
          ),
          atNotificationScreen(
            required,
            uid: uid,
          ),
          atProfileScreen(
            required,
            ownerId: uid,
          )
        ],
        controller: _tabController,
        //onPageChanged: whenPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        height: 48 + 34,
        padding: EdgeInsets.only(
            bottom: 34,
            left: (MediaQuery.of(context).size.width - 288) / 2,
            right: (MediaQuery.of(context).size.width - 288) / 2),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Container(
            color: Color(0xFFF5F5F5),
            child: TabBar(
              labelColor: blackLight,
              unselectedLabelColor: blackUltraLight,
              // indicator: UnderlineTabIndicator(
              //   borderSide: BorderSide(color: blackLight, width: 0.0),
              // ),
              //For Indicator Show and Customization
              indicatorColor: blackLight,
              tabs: <Widget>[
                Tab(
                    // icon: SvgPicture.asset(
                    //   nbDashboard,
                    //   height: 24, width: 24
                    // )
                    icon: Icon(Iconsax.global, size: 24)),
                Tab(
                    // icon: SvgPicture.asset(
                    //   nbAccountManagement,
                    //   height: 24, width: 24
                    // )
                    icon: Icon(Iconsax.search_normal, size: 24)),
                Tab(
                    // icon: SvgPicture.asset(
                    //   nbIncidentReport,
                    //   height: 24, width: 24
                    // )
                    icon: Icon(Iconsax.video_play, size: 24)),
                Tab(
                    // icon: SvgPicture.asset(
                    //   nbIncidentReport,
                    //   height: 24, width: 24
                    // )
                    icon: Icon(Iconsax.notification, size: 24)),
                Tab(
                  // icon: SvgPicture.asset(
                  //   nbIncidentReport,
                  //   height: 24, width: 24
                  // )
                  child: isLoading
                      ? SpinKitSpinningLines(
                          color: AppColors.black1,
                          size: 50.0,
                        )
                      : Container(
                          height: 24,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: black,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              (user.avatar != '')
                                  ? user.avatar
                                  : 'https://i.imgur.com/YtZkAbe.jpg',
                            ),
                          ),
                        ),
                ),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
