//import firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346_fricial_project/authentication/signInScreen.dart';
import 'package:se346_fricial_project/utils/utils.dart';

FirebaseAuth auth = FirebaseAuth.instance;
Future resetPasswordUser(String email, context) async {
  try {
    await auth.sendPasswordResetEmail(email: email).then((value) {
      showSnackBar(context, "Please check your email");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ),
      );
    });
  } on FirebaseAuthException catch (e) {
    print(e.code);
    switch (e.code) {
      case "invalid-email":
        showSnackBar(context, "Your email is invalid, please check!");
        break;
      case "user-not-found":
        showSnackBar(context, "Your email is not found, please check!");
        break;

      default:
        showSnackBar(context, "An undefined Error happened.");
    }
  }
}

signOut(context) async {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  await _firebaseAuth.signOut().then((value) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
  });
}
