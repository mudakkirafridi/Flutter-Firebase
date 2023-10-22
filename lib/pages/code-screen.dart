import 'package:flutter/material.dart';

class CodeScreen extends StatefulWidget {
  final String verifications;
  const CodeScreen({super.key, required this.verifications});

  @override
  State<CodeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
