import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase/utilities/utils.dart';
import 'package:flutter_firebase/widgets/roundBtn.dart';

class FirestorePostScreen extends StatefulWidget {
  const FirestorePostScreen({super.key});

  @override
  State<FirestorePostScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FirestorePostScreen> {
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('users');
  final postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Post Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: const InputDecoration(
                  hintText: "What's On Your Mind!",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                loading: loading,
                title: "Add",
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  fireStore.doc(id).set({
                    'title': postController.text.toString(),
                    "id": id
                  }).then((value) {
                    Utils().toastMessage(message: 'Your Post Added');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(message: error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
