import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:se346_fricial_project/constants/colors.dart';
import 'package:se346_fricial_project/models/reelModel.dart';
import 'package:se346_fricial_project/reels/contentScreen.dart';
import 'package:se346_fricial_project/reels/createReel.dart';

///add constants

import 'package:video_player/video_player.dart';

class atReelScreen extends StatefulWidget {
  String uid;
  atReelScreen(required, {Key? key, required this.uid}) : super(key: key);

  @override
  _atReelScreen createState() => _atReelScreen();
}

class _atReelScreen extends State<atReelScreen>
    with SingleTickerProviderStateMixin {
  String userId = '';

  List<reelModel> reelList = [];
  List videoList = [];
  List ownerId = [];
  List reelId = [];
  Future getReelList() async {
    FirebaseFirestore.instance
        .collection("reels")
        .orderBy('timeCreate', descending: true)
        .snapshots()
        .listen((value) {
      setState(() {
        reelList.clear();
        videoList.clear();
        ownerId.clear();
        value.docs.forEach((element) {
          reelList.add(reelModel.fromDocument(element.data()));
          videoList.add(element.data()['urlVideo']);
          ownerId.add(element.data()['userId']);
          reelId.add(element.data()['id']);
        });
        print("videoList");
        print(videoList);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    final userid = user?.uid.toString();
    userId = userid!;
    print(userId);
    getReelList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Fricial_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return ContentScreen(
                  src: videoList[index],
                  uid: ownerId[index],
                  reelId: reelId[index],
                );
              },
              itemCount: videoList.length,
              scrollDirection: Axis.vertical,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24, top: 24 + 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      // SizedBox(width: 117.5),
                      Container(
                        child: Text(
                          'Reel',
                          style: TextStyle(
                              fontFamily: 'Recoleta',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: white),
                        ),
                      ),
                      // SizedBox(width: 117.5),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        //             atPersonalInformationScreen(
                                        //                 required,
                                        //                 uid: ownerId))));

                                        atCreateReelScreen(context,
                                            uid: userId))));
                          },
                          child: Icon(Iconsax.camera, size: 28, color: white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // ContentScreen(like: like,)
          ],
        ),
      ),
    );
  }
}
