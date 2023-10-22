import 'package:flutter/material.dart';
import 'package:flutter_firebase/firebase-services/splash-services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplashScreen> {
  SplashServices ss = SplashServices();

  @override
  void initState() {
    super.initState();
    ss.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(221, 36, 35, 35),
      body: Center(
        child: Text(
          'Firebase With Flutter',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 23, color: Colors.white),
        ),
      ),
    );
  }
}
