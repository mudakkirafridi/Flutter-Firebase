import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/pages/post-screen.dart';
import 'package:flutter_firebase/pages/sign-up.dart';
import 'package:flutter_firebase/utilities/utils.dart';
import 'package:flutter_firebase/widgets/roundBtn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void logIn() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(message: 'Account Successfully Created');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const PostScreen()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(message: error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('LOGIN'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.alternate_email),
                                hintText: 'Email',
                                helperText:
                                    'Enter Email E.g mudakkir@gmail.com'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                hintText: 'Password',
                                helperText: 'Enter Password E.g Mudakir123'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              }
                              return null;
                            },
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  RoundButton(
                    title: 'LOGIN',
                    loading: loading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        logIn();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't Have An Account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text('SIGN UP'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
