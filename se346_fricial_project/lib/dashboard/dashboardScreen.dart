import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

///add constants
import 'package:se346_fricial_project/constants/colors.dart';
import 'package:se346_fricial_project/constants/fonts.dart';

class atDashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _atDashboardScreen();
}

class _atDashboardScreen extends State<atDashboardScreen>
    with SingleTickerProviderStateMixin {
  _atDashboardScreen();

  void initState() {
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
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent),
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: grey1),
              ),
              Container(
                padding: EdgeInsets.only(top: 32, right: 16, left: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Peter Chao',
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>

                                //   ),
                                // ).then((value) {});
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.topRight,
                                duration: Duration(milliseconds: 300),
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                    color: grey1,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          color: black.withOpacity(0.25),
                                          spreadRadius: 0,
                                          blurRadius: 64,
                                          offset: Offset(8, 8)),
                                      BoxShadow(
                                        color: black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
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
                        SizedBox(width: 16),
                        Container(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>

                              //   ),
                              // ).then((value) {});
                            },
                            child: Container(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.topRight,
                                child: Icon(Iconsax.message,
                                    size: 24, color: white)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // SizedBox(height: 32),
              Container(
                  margin: EdgeInsets.only(top: 88, left: 16),
                  height: 78,
                  width: 375,
                  child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 16),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              //stories
                            },
                            child: (index == 0)
                                ? Container(
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                                width: 56,
                                                height: 56,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: white,
                                                      width: 1.5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8)))),
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Image.network(
                                                  'https://i.imgur.com/bCnExb4.jpg',
                                                  width: 48,
                                                  height: 48,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                            child: Text(
                                          'Your Story',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.normal,
                                              color: white),
                                        ))
                                      ],
                                    ),
                                  )
                                : Container(
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                                width: 56,
                                                height: 56,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: white,
                                                      width: 1.5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8)))),
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Image.network(
                                                  'https://i.imgur.com/eYOEUb7.jpg',
                                                  width: 48,
                                                  height: 48,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                            child: Text(
                                          'Pan',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.normal,
                                              color: white),
                                        ))
                                      ],
                                    ),
                                  ));
                      })),
              Container(
                  margin: EdgeInsets.only(
                      top: 88 + 16 + 56 + 8 + 12, left: 16, right: 16),
                  child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 16),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.network(
                                                'https://i.imgur.com/eYOEUb7.jpg',
                                                width: 32,
                                                height: 32,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Container(
                                              child: Text(
                                            'Peter Chao',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                color: white),
                                          ))
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      alignment: Alignment.topRight,
                                      child: Icon(Iconsax.more,
                                          size: 24, color: white),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://i.imgur.com/eYOEUb7.jpg',
                                    width: 360,
                                    height: 340,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        //love post
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 8),
                                        alignment: Alignment.topRight,
                                        child: Icon(Iconsax.heart,
                                            size: 24, color: white),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        //comment post
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Icon(Iconsax.message_text,
                                            size: 24, color: white),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        //save post
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 8),
                                        child: Icon(Iconsax.save_2,
                                            size: 24, color: white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              GestureDetector(
                                onTap: () {
                                  //likes post
                                },
                                child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '100' + ' likes',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        );
                      }))
            ],
          ),
        ));
  }
}
