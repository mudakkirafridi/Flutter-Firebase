import 'dart:async';
import 'package:flutter_firebase/pages/sign-up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/pages/upload-image.dart';

class SplashServices {
  isLogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 4), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ImageUploadFirebase()));
      });
    } else {
      Timer(const Duration(seconds: 4), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()));
      });
    }
  }
}
