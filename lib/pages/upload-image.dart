import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utilities/utils.dart';
import 'package:flutter_firebase/widgets/roundBtn.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadFirebase extends StatefulWidget {
  const ImageUploadFirebase({super.key});

  @override
  State<ImageUploadFirebase> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ImageUploadFirebase> {
  bool loading = false;
  File? _imageFile;
  final imagePicker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref('posts');

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image To Firebase'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _pickImage(ImageSource.gallery);
              },
              child: Container(
                height: 200,
                width: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Center(
                  child: _imageFile != null
                      ? Image.file(_imageFile!.absolute)
                      : const Icon(Icons.image),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            RoundButton(
                loading: loading,
                title: 'Upload',
                onTap: () async {
                  setState(() {
                    loading = true;
                  });

                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref('/mudakir' + '1');
                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(_imageFile!.absolute);
                  await Future.value(uploadTask);
                  var newURL = await ref.getDownloadURL();

                  databaseReference.child('1').set(
                      {'id': '123', 'title': newURL.toString()}).then((value) {
                    Utils().toastMessage(message: 'Uploaded');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(message: error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
