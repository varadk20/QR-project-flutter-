// TODO Implement this library.

import 'package:flutter/material.dart';

class GenerateCodePage extends StatefulWidget {
  const GenerateCodePage({super.key});

  @override
  State<GenerateCodePage> createState() => GenerateCodePageState();
}

class GenerateCodePageState extends State<GenerateCodePage> {
  String? qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate QR code"),
        backgroundColor: Colors.amber.shade600,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/scan");
            },
            icon: const Icon(
              Icons.qr_code_scanner,
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Text(
            "Hi this is generator",
            style: TextStyle(color: Colors.blueAccent.shade400, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
