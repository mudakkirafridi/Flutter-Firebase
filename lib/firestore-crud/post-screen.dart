import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/firestore-crud/firestore-post-screen.dart';
import 'package:flutter_firebase/pages/sign-up.dart';
import 'package:flutter_firebase/utilities/utils.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('users').snapshots();
  final searchFilter = TextEditingController();
  final dialogController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post NewsFeed Screen"),
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
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Some error occured'),
                  );
                }
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                snapshot.data!.docs[index]['title'].toString()),
                          );
                        }));
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const FirestorePostScreen()));
        },
        child: const Icon(Icons.post_add_outlined),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    dialogController.text = title;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('update'),
            content: Container(
              child: TextFormField(
                controller: dialogController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Edit Here"),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Update'))
            ],
          );
        });
  }
}
