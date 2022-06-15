import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//colors used in this app

const Color white = Colors.white;
const Color whiteLight = Color(0xFFF5F5F5);
const Color black = Color(0xFF101010);
const Color gray = Color(0xFF808080);
const Color light = Color(0xFFe8e8e8);
const Color pink = Color(0xFFe5b6ab);

const Color red = Colors.red;
const Color green = Colors.green;
const Color blue = Colors.lightBlue;

const Color blackLight = Color(0xFF061D32);
const Color blackUltraLight = Color(0xFF3E4D5B);

const Color grey1 = Color(0xFF202128);
const Color grey8 = Color(0xFF999999);
const Color greyC = Color(0xFFCCCCCC);
const Color greyD = Color(0xFFDDDDDD);

const Color blueWater = Color(0xFF5FAAEF);
const Color blueLight = Color(0xFFDDF1FF);

const Color redLight = Color(0xFFDFBEB9);

final Shader blackLightShader = LinearGradient(
  colors: <Color>[blackLight, blackLight],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
);
