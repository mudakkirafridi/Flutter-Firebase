import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/code-screen.dart';
import 'package:flutter_firebase/utilities/utils.dart';
import 'package:flutter_firebase/widgets/roundBtn.dart';

class PhoneNOScreen extends StatefulWidget {
  const PhoneNOScreen({super.key});

  @override
  State<PhoneNOScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PhoneNOScreen> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login With Phone Number'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: phoneNumberController,
              decoration:
                  const InputDecoration(hintText: 'Enter Your Phone No'),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
                title: "LogIn",
                onTap: () {
                  auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text.toString(),
                      verificationCompleted: (context) {},
                      verificationFailed: (e) {
                        Utils().toastMessage(message: e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CodeScreen(
                                      verifications: verificationId,
                                    )));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        Utils().toastMessage(message: e.toString());
                      });
                })
          ],
        ),
      ),
    );
  }
}
