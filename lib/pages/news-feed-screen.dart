import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utilities/utils.dart';
import 'package:flutter_firebase/widgets/roundBtn.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewsFeedScreen> {
  bool loading = false;
  final dbRefrence = FirebaseDatabase.instance.ref("posts");
  final postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feeds'),
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
                  dbRefrence.child(id).set({
                    "title": postController.text.toString(),
                    "id": id
                  }).then((value) {
                    setState(() {
                      loading = false;
                      postController.text = '';
                    });
                    Utils().toastMessage(message: 'Post send successfully');
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
