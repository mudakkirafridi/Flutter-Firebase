import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/pages/sign-up.dart';
import 'package:flutter_firebase/utilities/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Screen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(message: error.toString());
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
