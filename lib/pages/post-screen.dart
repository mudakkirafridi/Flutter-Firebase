import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/pages/news-feed-screen.dart';
import 'package:flutter_firebase/pages/sign-up.dart';
import 'package:flutter_firebase/utilities/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final dbref = FirebaseDatabase.instance.ref("posts");
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
          TextFormField(
            controller: searchFilter,
            decoration: const InputDecoration(
                hintText: 'Search', border: OutlineInputBorder()),
            onChanged: (String value) {
              setState(() {});
            },
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: dbref,
                itemBuilder: (context, snapshot, index, animation) {
                  final title = snapshot.child('title').value.toString();
                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  showMyDialog(title,
                                      snapshot.child('id').value.toString());
                                },
                                leading: const Icon(Icons.edit),
                                title: const Text('Edit'),
                              )),
                          PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  dbref
                                      .child(
                                          snapshot.child('id').value.toString())
                                      .remove();
                                },
                                leading: const Icon(Icons.delete),
                                title: const Text('Delete'),
                              )),
                        ],
                      ),
                    );
                  } else if (title
                      .toLowerCase()
                      .contains(searchFilter.text.toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const NewsFeedScreen()));
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
                    dbref.child(id).update({
                      'title': dialogController.text.toLowerCase()
                    }).then((value) {
                      Utils().toastMessage(message: 'Successfully Updated');
                      Navigator.pop(context);
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(message: error.toString());
                    });
                  },
                  child: const Text('Update'))
            ],
          );
        });
  }
}
