import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:se346_fricial_project/constants/colors.dart';
import 'package:se346_fricial_project/models/user.dart';
import 'package:video_player/video_player.dart';

class followerWidget extends StatefulWidget {
  String uid;

  followerWidget({Key? key, required this.uid}) : super(key: key);

  bool liked = false;
  @override
  _followerWidgetState createState() => _followerWidgetState(this.uid);
}

class _followerWidgetState extends State<followerWidget> {
  String uid = '';
  late userModel owner = userModel(
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

  _followerWidgetState(this.uid);

  Future getOwnerDetail() async {
    print(uid.replaceAll(r'[', '').replaceAll(r']', ''));
    FirebaseFirestore.instance
        .collection("users")
        .where("userId",
            isEqualTo: uid.replaceAll(r'[', '').replaceAll(r']', ''))
        .snapshots()
        .listen((value) {
      setState(() {
        owner = userModel.fromDocument(value.docs.first.data());
        print(owner.userName);
        print("owner.background 123");
        print(owner.avatar);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getOwnerDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _liked = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 0, right: 16),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage((owner.avatar != '')
                          ? owner.avatar
                          : 'https://i.imgur.com/RUgPziD.jpg'),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 8),
              Text(
                owner.userName,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
