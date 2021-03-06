import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se346_fricial_project/constants/colors.dart';
import 'package:se346_fricial_project/dashboard/createPost.dart';
import 'package:se346_fricial_project/firebase/auth.dart';
import 'package:se346_fricial_project/models/postModel.dart';

import 'dart:math' as math;

import 'package:se346_fricial_project/models/user.dart';
import 'package:se346_fricial_project/profile/editProfileScreen.dart';
import 'package:se346_fricial_project/profile/followerWidget.dart';
import 'package:se346_fricial_project/resources/storage_methods.dart';
import 'package:se346_fricial_project/search/ImageWidget.dart';
import 'package:se346_fricial_project/search/videoWidget.dart';

class atProfileScreen extends StatefulWidget {
  String ownerId;
  atProfileScreen(required, {Key? key, required this.ownerId})
      : super(key: key);

  @override
  _atProfileScreen createState() => _atProfileScreen(ownerId);
}

class _atProfileScreen extends State<atProfileScreen>
    with SingleTickerProviderStateMixin {
  String userId = '';
  String ownerId = '';
  _atProfileScreen(this.ownerId);
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
  Future getOwnerDetail() async {
    FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: ownerId)
        .snapshots()
        .listen((value) {
      setState(() {
        idFollowers.clear();
        owner = userModel.fromDocument(value.docs.first.data());
        photoUrl = owner.avatar;
        idFollowers = owner.favoriteList;
      });
    });
  }

  List idFollowers = [];
  Future getUserDetail() async {
    FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: userId)
        .snapshots()
        .listen((value) {
      setState(() {
        user = userModel.fromDocument(value.docs.first.data());
        if (user.favoriteList.isNotEmpty) {}
      });
    });
  }

  Future followEvent(List follow) async {
    if (follow.contains(ownerId)) {
      FirebaseFirestore.instance.collection('users').doc(userId).update({
        'follow': FieldValue.arrayRemove([ownerId]),
      });
      FirebaseFirestore.instance.collection('users').doc(ownerId).update({
        'favoriteList': FieldValue.arrayRemove([userId])
      });
    } else {
      FirebaseFirestore.instance.collection('users').doc(userId).update({
        'follow': FieldValue.arrayUnion([ownerId])
      });
      FirebaseFirestore.instance.collection('users').doc(ownerId).update({
        'favoriteList': FieldValue.arrayUnion([userId])
      });
    }
  }

  late List<postModel> postList = [];
  late List<postModel> postListImage = [];
  Future getPostList() async {
    FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: ownerId)
        .snapshots()
        .listen((value) {
      setState(() {
        postList.clear();
        value.docs.forEach((element) {
          postList.add(postModel.fromDocument(element.data()));
        });
        postList.forEach((element) {
          if (element.urlVideo != '') {
            postVideoList.add(element);
          } else {
            postListImage.add(element);
          }
        });
      });
    });
  }

  late List<postModel> postVideoList = [];

  bool followed = false;
  final pageViewcontroller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

  TabController? _tabController;

  String photoUrl = '';

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: false,
    );
    print('result');
    print(result);
    if (result != null) {
      photoUrl = await StorageMethods().uploadImageToStorage(
          'profilePics', File(result.files.first.path.toString()), false);

      await FirebaseFirestore.instance.collection("users").doc(ownerId).update({
        'avatar': photoUrl,
      });
      return File(result.files.first.path.toString());
    }
  }

  String backgroundUrl = '';
  pickImageBackground() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: false,
    );
    print('result');
    print(result);
    if (result != null) {
      backgroundUrl = await StorageMethods().uploadImageToStorage(
          'uploads', File(result.files.first.path.toString()), false);

      await FirebaseFirestore.instance.collection("users").doc(ownerId).update({
        'background': backgroundUrl,
      });
      return File(result.files.first.path.toString());
    }
  }

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    final userid = user?.uid.toString();
    userId = userid!;
    super.initState();
    getOwnerDetail();
    getUserDetail();
    getPostList();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        child: Scaffold(
          body: PageView(
            scrollDirection: Axis.vertical,
            controller: pageViewcontroller,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Fricial_background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(children: [
                  GestureDetector(
                    onTap: () {
                      if (userId == ownerId) {
                        pickImageBackground();
                      }
                    },
                    child: Container(
                        height: 186,
                        width: 375 + 24,
                        decoration: BoxDecoration(
                          color: white,
                        ),
                        child: Image.network(
                            (owner.background != '')
                                ? owner.background
                                : 'https://i.imgur.com/RUgPziD.jpg',
                            fit: BoxFit.cover)),
                  ),
                  (ownerId != userId)
                      ? IconButton(
                          padding: EdgeInsets.only(left: 28),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Iconsax.arrow_square_left,
                              size: 28, color: white),
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20 + 186),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              (ownerId != userId)
                                  ? (Row(
                                      children: [
                                        (user.follow.contains(ownerId))
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    followed = !followed;
                                                    followEvent(user.follow);
                                                  });
                                                },
                                                child: Container(
                                                  width: 72 + 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    color: white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text('Following',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: white)),
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    followed = !followed;
                                                    followEvent(user.follow);
                                                  });
                                                },
                                                child: Container(
                                                  width: 72,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    color: gray,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text('Follow',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: white)),
                                                  ),
                                                ),
                                              ),
                                        Container(
                                          padding: EdgeInsets.only(left: 16),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: ((context) =>
                                              //             atPersonalInformationScreen(
                                              //                 required,
                                              //                 uid: ownerId))));
                                            },
                                            child: Container(
                                                padding:
                                                    EdgeInsets.only(right: 16),
                                                child: Icon(Iconsax.message,
                                                    size: 24, color: white)),
                                          ),
                                        ),
                                        Container(
                                          child: GestureDetector(
                                            onTap: () {
                                              print('tap option');
                                            },
                                            child: Container(
                                                child: Icon(Iconsax.more,
                                                    size: 24, color: white)),
                                          ),
                                        ),
                                      ],
                                    ))
                                  : Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        EditProfileScreen())));
                                          },
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(right: 16),
                                              child: Icon(Iconsax.edit_2,
                                                  size: 24, color: white)),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            signOut(context);
                                          },
                                          child: Container(
                                              child: Icon(Iconsax.logout,
                                                  size: 24, color: white)),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(owner.userName,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: white)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 8),
                              width: 327 + 24,
                              alignment: Alignment.topLeft,
                              child: Text(
                                  'Turmoil is always your hero \nFollow on Facebook: https://www.facebook.com/minthin.2108/',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: white)),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child:
                                  //  Linkify(
                                  //   text:
                                  //       'https://baemyungseong.github.io/portfolio_website',
                                  //   style: TextStyle(
                                  //       fontFamily: 'Poppins',
                                  //       fontSize: 20,
                                  //       fontWeight: FontWeight.w600,
                                  //       color: white),
                                  //   onOpen: _onOpen,
                                  // )
                                  RichText(
                                      text: TextSpan(children: [
                                TextSpan(
                                  text:
                                      'https://baemyungseong.github.io/portfolio_website',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: white),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {},
                                )
                              ])),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 192,
                            height: 0.5,
                            decoration: BoxDecoration(
                              color: gray,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 144,
                            height: 0.5,
                            decoration: BoxDecoration(
                              color: gray,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        (postList.length == 0)
                                            ? '0'
                                            : postList.length.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Posts",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color: gray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 63.5),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        (owner.favoriteList.length == 0)
                                            ? '0'
                                            : owner.favoriteList.length
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Followers",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color: gray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 63.5),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        (owner.follow.length == 0)
                                            ? '0'
                                            : owner.follow.length.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Following",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color: gray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Transform.rotate(
                                angle: 180 * math.pi / (180 * 2),
                                child: GestureDetector(
                                  onTap: () {
                                    print('more');
                                  },
                                  child: Icon(Iconsax.more,
                                      size: 24, color: white),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 64,
                            height: 0.5,
                            decoration: BoxDecoration(
                              color: gray,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              child: Text(
                                "Followers",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: white,
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                print('See all');
                              },
                              child: Text(
                                "See all",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: gray,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          // width: 367,
                          height: 72 + 8,
                          child: ListView.builder(
                              padding: EdgeInsets.only(left: 0),
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: idFollowers.length,
                              // userList.length.clamp(0, 3),
                              itemBuilder: (context, index) {
                                return followerWidget(
                                    uid: idFollowers[index].toString());
                              }),
                        ),
                        SizedBox(height: 24),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 64,
                            height: 0.5,
                            decoration: BoxDecoration(
                              color: gray,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Photos",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: white,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          // width: 367,
                          height: 56,
                          child: ListView.builder(
                              padding: EdgeInsets.only(left: 0),
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: postListImage.length,
                              // userList.length.clamp(0, 3),
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 0, right: 16),
                                      child: Container(
                                        width: 56,
                                        height: 56,
                                        decoration: new BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  // userList[index]
                                                  //     .avatar
                                                  postListImage[index]
                                                      .urlImage),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(height: 24),
                        Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                pageViewcontroller.nextPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.linear);
                              });
                            },
                            icon: Icon(Iconsax.arrow_square_down,
                                size: 28, color: white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (userId == ownerId) {
                        pickImage();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 24, top: 98 + 44),
                      child: Container(
                        width: 88,
                        height: 88,
                        decoration: new BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  // userList[index]
                                  //     .avatar
                                  (photoUrl != '')
                                      ? photoUrl
                                      : 'https://i.imgur.com/RUgPziD.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Fricial_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                      child: Column(
                    children: [
                      SizedBox(height: 24 + 20),
                      Container(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              pageViewcontroller.previousPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.linear);
                            });
                          },
                          icon: Icon(Iconsax.arrow_square_up,
                              size: 28, color: white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 24, right: 24),
                        child: Row(
                          children: [
                            Container(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              atCreatePostScreen(required,
                                                  uid: userId)),
                                    );
                                  },
                                  child: AnimatedContainer(
                                    alignment: Alignment.topRight,
                                    duration: Duration(milliseconds: 300),
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.5,
                                        )),
                                    child: Container(
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.center,
                                        child: Icon(Iconsax.add,
                                            size: 16, color: white)),
                                  ),
                                )),
                            Spacer(),
                            Container(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.topRight,
                                    child: Icon(Iconsax.menu_1,
                                        size: 24, color: white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        margin: EdgeInsets.only(left: 24, right: 24),
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(
                                      // userList[index]
                                      //     .avatar
                                      user.avatar), fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 32),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        owner.userName,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  (postList.length == 0)
                                                      ? ''
                                                      : postList.length
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    color: white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  "Posts",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    color: gray,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 32),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  (owner.follow.length == 0)
                                                      ? ''
                                                      : owner.follow.length
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    color: white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  "Followers",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    color: gray,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 32),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  (owner.follow.length == 0)
                                                      ? ''
                                                      : owner.follow.length
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    color: white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  "Following",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    color: gray,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 56,
                        width: 375 + 24,
                        child: Container(
                          color: Colors.transparent,
                          child: TabBar(
                            labelColor: white,
                            unselectedLabelColor: Colors.transparent,
                            indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(color: white, width: 1)),
                            //For Indicator Show and Customization
                            indicatorColor: white,
                            tabs: [
                              Tab(
                                icon: Icon(Iconsax.grid_8,
                                    color: white, size: 24),
                              ),
                              Tab(
                                icon: Icon(Iconsax.video_circle,
                                    color: white, size: 24),
                              ),
                              Tab(
                                icon: Icon(Iconsax.save_2,
                                    color: white, size: 24),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: _tabController,
                        children: [
                          profileTabPostScreen(postList),
                          profileTabVideoScreen(postVideoList),
                          profileTabPostScreen(postList),
                        ],
                      ))
                    ],
                  )))
            ],
          ),
        ),
      ),
    );
  }

  profileTabPostScreen(List postList) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24),
      child: GridView.custom(
        gridDelegate: (postList.length >= 4)
            ? SliverQuiltedGridDelegate(
                crossAxisCount: 3,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  QuiltedGridTile(2, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 2),
                ],
              )
            : SliverQuiltedGridDelegate(
                crossAxisCount: 3,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [QuiltedGridTile(1, 1)],
              ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            // (postList.length == 0)
            //     ? Container()
            //     :
            return (postList[index].urlImage != '')
                ? ImageWidget(
                    src: postList[index].urlImage,
                    postId: postList[index].id,
                    uid: userId,
                    position: index.toString(),
                  )
                : VideoWidget(
                    src: postList[index].urlVideo,
                    postId: postList[index].id,
                    uid: userId,
                    position: index.toString(),
                  );
          },
          childCount: postList.length,
        ),
      ),
    );
  }

  profileTabVideoScreen(List postList) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24),
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: postList.length,
        itemBuilder: (context, index) {
          // (postList.length == 0)
          //     ? Container()
          //     :
          return VideoWidget(
            src: postList[index].urlVideo,
            postId: postList[index].id,
            uid: userId,
            position: index.toString(),
          );
        },
      ),
    );
  }

  profileTabReelScreen(List postList) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24),
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: postList.length,
        itemBuilder: (context, index) {
          // (postList.length == 0)
          //     ? Container()
          //     :
          return VideoWidget(
            src: postList[index].urlVideo,
            postId: postList[index].id,
            uid: userId,
            position: index.toString(),
          );
        },
      ),
    );
  }
}
