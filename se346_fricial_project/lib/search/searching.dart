import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:se346_fricial_project/constants/colors.dart';
import 'package:se346_fricial_project/models/postModel.dart';
import 'package:se346_fricial_project/models/user.dart';
import 'package:se346_fricial_project/search/ImageWidget.dart';
import 'package:se346_fricial_project/search/videoWidget.dart';

///add constants
import 'package:tflite/tflite.dart';

class atSearchScreen extends StatefulWidget {
  String uid;
  atSearchScreen(required, {Key? key, required this.uid}) : super(key: key);

  @override
  _atSearchScreen createState() => _atSearchScreen(uid);
}

class _atSearchScreen extends State<atSearchScreen>
    with SingleTickerProviderStateMixin {
  String uid = '';
  _atSearchScreen(this.uid);
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String search = '';
  List<userModel> userList = [];
  List<postModel> postListCaption = [];
  Future searchUserName() async {
    FirebaseFirestore.instance.collection("posts").snapshots().listen((value) {
      setState(() {
        postListCaption.clear();
        postList.clear();
        value.docs.forEach((element) {
          postListCaption.add(postModel.fromDocument(element.data()));
        });

        postListCaption.forEach((element) {
          print(
              (element.caption.toUpperCase().contains(search.toUpperCase())) ==
                  true);
          if (((element.caption + " ")
                  .toUpperCase()
                  .contains(search.toUpperCase())) ==
              true) {
            postList.add(element);
            print(postList.length);
          }
        });
        if (postList.isEmpty) {}
      });
    });
  }

  late List<postModel> postList = [];
  Future getPostList() async {
    FirebaseFirestore.instance.collection('posts').snapshots().listen((value) {
      setState(() {
        postList.clear();
        value.docs.forEach((element) {
          postList.add(postModel.fromDocument(element.data()));
        });
        postList.forEach((element) {});
      });
    });
  }

  File? imageFile;
  String link = '';

  late String urlImage = '';

  @override
  void initState() {
    getPostList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        child: Scaffold(
            body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Fricial_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 32, right: 16, left: 16),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Form(
                    // key: formKey,
                    child: Container(
                      width: 327 + 24,
                      height: 40,
                      padding: EdgeInsets.only(left: 2, right: 24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8), color: white),
                      alignment: Alignment.topCenter,
                      child: TextFormField(
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: black,
                              fontWeight: FontWeight.w400),
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          onChanged: (val) {
                            search = val;
                            searchUserName();
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            prefixIcon: Container(
                                child: Icon(Iconsax.search_normal_1,
                                    size: 20, color: black)),
                            border: InputBorder.none,
                            hintText: "What are you looking for?",
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                  ),
                ),
                Container(
                    width: 327 + 24,
                    height: 400,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                      ),
                      itemCount: postList.length,
                      // userList.length.clamp(0, 3),
                      itemBuilder: (context, index) {
                        // (postList.length == 0)
                        //     ? Container()
                        //     :
                        return (postList[index].urlImage != '')
                            ? Container(
                                child: ImageWidget(
                                  src: postList[index].urlImage,
                                  postId: postList[index].id,
                                  uid: uid,
                                  position: index.toString(),
                                ),
                              )
                            : Container(
                                child: VideoWidget(
                                  src: postList[index].urlVideo,
                                  postId: postList[index].id,
                                  uid: uid,
                                  position: index.toString(),
                                ),
                              );
                      },
                    )),
              ],
            ),
          )
        ])));
  }
}
