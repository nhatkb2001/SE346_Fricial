import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:se346_fricial_project/authentication/signInScreen.dart';

///add ants
import 'package:se346_fricial_project/constants/colors.dart';
import 'package:se346_fricial_project/constants/fonts.dart';
import 'package:se346_fricial_project/dashboard/createPost.dart';
import 'package:se346_fricial_project/dashboard/dashboardScreen.dart';
import 'package:se346_fricial_project/models/postModel.dart';
import 'package:se346_fricial_project/models/user.dart';
import 'package:se346_fricial_project/search/imageWidget.dart';
import 'package:se346_fricial_project/search/videoWidget.dart';

class atProfileScreen extends StatefulWidget {
  String ownerId;
  atProfileScreen(required, {Key? key, required this.ownerId})
      : super(key: key);
  @override
  _atProfileScreen createState() => _atProfileScreen(this.ownerId);
}

class _atProfileScreen extends State<atProfileScreen>
    with SingleTickerProviderStateMixin {
  String ownerId = '';
  String uid = '';
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

  Future getUserDetail() async {
    FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: ownerId)
        .snapshots()
        .listen((value) {
      setState(() {
        user = userModel.fromDocument(value.docs.first.data());
        print(user.userName);
      });
    });
  }

  late List<postModel> postList = [];
  late List<postModel> postListImage = [];
  late List<postModel> postVideoList = [];
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

  TabController? _tabController;

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    final userid = user?.uid.toString();
    uid = userid!;
    getUserDetail();
    getPostList();
    super.initState();
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
      child: Scaffold(
        backgroundColor: pink,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // topbar
              SizedBox(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.only(top: 32, right: 16, left: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            user.userName,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: black,
                            ),
                          ),
                        ),
                        Spacer(),
                        (ownerId != uid)
                            ? Container()
                            : Row(
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
                                                        uid: ownerId)),
                                          );
                                        },
                                        child: AnimatedContainer(
                                          alignment: Alignment.topRight,
                                          duration: Duration(milliseconds: 300),
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1.5,
                                              )),
                                          child: Container(
                                              padding: EdgeInsets.zero,
                                              alignment: Alignment.center,
                                              child: Icon(Iconsax.add,
                                                  size: 16, color: black)),
                                        ),
                                      )),
                                  SizedBox(width: 16),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           messsageScreen(required, uid: uid)),
                                        // );
                                      },
                                      child: Container(
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.topRight,
                                          child: Icon(Iconsax.message,
                                              size: 24, color: black)),
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(height: 1),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 14),
                    // prifule statistic
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              (user.avatar != '')
                                  ? user.avatar
                                  : 'https://i.imgur.com/RUgPziD.jpg',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '59',
                                  style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Posts',
                                  style: TextStyle(
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '1,179',
                                  style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '1,042',
                                  style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Following',
                                  style: TextStyle(
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    // bio
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        user.userName,
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    // buttons
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Your fellow amateur',
                        style: TextStyle(
                          color: black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'solo.to/nadahasnim',
                        style: TextStyle(
                          color: black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: (ownerId == uid)
                            ? Row(
                                children: [
                                  ProfileButton(text: 'Edit Profile'),
                                  SizedBox(width: 8),
                                  ProfileButton(text: 'Log out'),
                                ],
                              )
                            : Row(
                                children: [
                                  (user.follow.contains(uid))
                                      ? ProfileButton(text: 'Follow')
                                      : ProfileButton(text: 'Following'),
                                  SizedBox(width: 8),
                                  ProfileButton(text: 'Contact'),
                                ],
                              )),

                    SizedBox(height: 24),
                    // higlights
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 74,
                                width: 74,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: black,
                                  ),
                                  borderRadius: BorderRadius.circular(74),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    'https://i.imgur.com/FM1fqIy.jpg',
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text('manipulation'),
                            ],
                          ),
                          SizedBox(width: 14),
                          Column(
                            children: [
                              Container(
                                height: 74,
                                width: 74,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: black,
                                  ),
                                  borderRadius: BorderRadius.circular(74),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    'https://i.imgur.com/FM1fqIy.jpg',
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text('BTS II'),
                            ],
                          ),
                          SizedBox(width: 14),
                          Column(
                            children: [
                              Container(
                                height: 74,
                                width: 74,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: black,
                                  ),
                                  borderRadius: BorderRadius.circular(74),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    'https://i.imgur.com/FM1fqIy.jpg',
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text('BTS'),
                            ],
                          ),
                          SizedBox(width: 14),
                          Column(
                            children: [
                              Container(
                                height: 74,
                                width: 74,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: black,
                                  ),
                                  borderRadius: BorderRadius.circular(74),
                                ),
                                child: Center(
                                  child: Icon(Icons.add, size: 40),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text('New'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      height: 56,
                      width: 375 + 24,
                      child: Container(
                        color: Colors.transparent,
                        child: TabBar(
                          labelColor: black,
                          unselectedLabelColor: Colors.transparent,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(color: black, width: 1)),
                          //For Indicator Show and Customization
                          indicatorColor: black,
                          tabs: [
                            Tab(
                              icon:
                                  Icon(Iconsax.grid_8, color: black, size: 24),
                            ),
                            Tab(
                              icon: Icon(Iconsax.video_circle,
                                  color: black, size: 24),
                            ),
                            Tab(
                              icon:
                                  Icon(Iconsax.save_2, color: black, size: 24),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  profileTabPostScreen(List postList) {
    return Container(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: postList.length,
        itemBuilder: (context, index) {
          // (postList.length == 0)
          //     ? Container()
          //     :
          return (postList[index].urlImage != '')
              ? ImageWidget(
                  src: postList[index].urlImage,
                  postId: postList[index].id,
                  uid: ownerId,
                  position: index.toString(),
                )
              : VideoWidget(
                  src: postList[index].urlVideo,
                  postId: postList[index].id,
                  uid: ownerId,
                  position: index.toString(),
                );
        },
      ),
    );
  }

  profileTabVideoScreen(List postList) {
    return Container(
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
            uid: ownerId,
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
            uid: ownerId,
            position: index.toString(),
          );
        },
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  ProfileButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    switch (text) {
      case 'Edit Profile':
        return Expanded(
          child: GestureDetector(
            onTap: () {
              print('Edit Profile');
            },
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: black, width: 1),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        );
      case 'Log out':
        return Expanded(
          child: GestureDetector(
            onTap: () async {
              FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
              await _firebaseAuth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            },
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: black, width: 1),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        );
      case 'Follow':
        return Expanded(
          child: GestureDetector(
            onTap: () {
              print('Follow');
            },
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: black, width: 1),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        );
      case 'Following':
        return Expanded(
          child: GestureDetector(
            onTap: () {
              print('Following');
            },
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: black, width: 1),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        );
      case 'Contact':
        return Expanded(
          child: GestureDetector(
            onTap: () {
              print('Contact');
            },
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: black, width: 1),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        );
    }
    return Container();
  }
}
