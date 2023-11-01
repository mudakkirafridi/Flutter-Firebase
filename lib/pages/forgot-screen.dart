import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utilities/utils.dart';
import 'package:flutter_firebase/widgets/roundBtn.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ForgotPasswordScreen> {
  final forgotEmailContoller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: forgotEmailContoller,
              decoration: const InputDecoration(
                  hintText: 'mudakkirafridi@gmail.com',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 40,
            ),
            RoundButton(
                title: 'Forgot',
                onTap: () {
                  auth
                      .sendPasswordResetEmail(
                          email: forgotEmailContoller.text.toString())
                      .then((value) {
                    Utils().toastMessage(message: 'Email Send Successfully');
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
