import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:se346_fricial_project/constants/colors.dart';
import 'package:se346_fricial_project/models/notifyModel.dart';
import 'package:se346_fricial_project/notification/postNotification.dart';

///add constants

class atNotificationScreen extends StatefulWidget {
  String uid;
  atNotificationScreen(required, {Key? key, required this.uid})
      : super(key: key);

  @override
  _atNotificationScreen createState() => _atNotificationScreen(this.uid);
}

class _atNotificationScreen extends State<atNotificationScreen>
    with SingleTickerProviderStateMixin {
  List<notifyModel> notifyList = [];
  String uid = '';
  _atNotificationScreen(this.uid);

  Future getNotifiesList() async {
    print(widget.uid);
    FirebaseFirestore.instance
        .collection("notifies")
        // .orderBy('timeCreate', descending: true)
        .where('idReceiver', isEqualTo: widget.uid)
        .snapshots()
        .listen((value) {
      setState(() {
        notifyList.clear();
        value.docs.forEach((element) {
          notifyList.add(notifyModel.fromDocument(element.data()));
        });
        print("notifyList.length");
        print(notifyList.length);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getNotifiesList();
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
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Container(
                    margin: EdgeInsets.only(left: 24, right: 24, top: 20 + 20),
                    child: Column(
                      children: [
                        Container(
                            child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Notification',
                                style: TextStyle(
                                    fontFamily: 'Recoleta',
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    color: white),
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        )),
                        Container(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(top: 8),
                              shrinkWrap: true,
                              itemCount: notifyList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    width: 327 + 24,
                                    margin: EdgeInsets.only(top: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(color: gray),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    postNotification(
                                                      context,
                                                      postId: notifyList[index]
                                                          .idPost,
                                                      uid: uid,
                                                    ))));
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 44,
                                            height: 44,
                                            margin: EdgeInsets.only(
                                                left: 16, bottom: 16, top: 16),
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      // userList[index]
                                                      //     .avatar
                                                      (notifyList[index]
                                                                  .avatarSender !=
                                                              '')
                                                          ? notifyList[index]
                                                              .avatarSender
                                                          : 'https://i.imgur.com/RUgPziD.jpg'),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          Container(
                                            width: 183 + 24,
                                            margin: EdgeInsets.only(left: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16,
                                                          color: black,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                        children: <TextSpan>[
                                                      TextSpan(
                                                        text: notifyList[index]
                                                            .nameSender,
                                                        style: TextStyle(
                                                          color: white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: " " +
                                                            notifyList[index]
                                                                .content,
                                                        style: TextStyle(
                                                          color: gray,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ])),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Today, at ' +
                                                        notifyList[index]
                                                            .timeCreate,
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                        color: gray,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                              }),
                        ),
                      ],
                    ))),
          )
        ])));
  }
}
