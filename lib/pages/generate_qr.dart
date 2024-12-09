import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';

class GenerateCodePage extends StatefulWidget {
  const GenerateCodePage({super.key});

  @override
  State<GenerateCodePage> createState() => GenerateCodePageState();
}

class GenerateCodePageState extends State<GenerateCodePage> {
  String? qrData;
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Generate QR Code"),
        backgroundColor: Colors.amber.shade600,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/scan");
            },
            icon: const Icon(Icons.qr_code_scanner),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              onSubmitted: (value) {
                setState(() {
                  qrData = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Please enter value for QR generation",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            if (qrData != null)
              Column(
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: Container(
                      color: Colors.white, // Ensure a proper background color
                      padding: const EdgeInsets.all(8.0),
                      child: PrettyQrView.data(
                        data: qrData!,
                        
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (qrData != null) {
                        try {
                          // Add a delay to ensure proper rendering
                          await Future.delayed(const Duration(milliseconds: 500));
                          final image = await screenshotController.capture();
                          if (image != null) {
                            final directory = await Directory.systemTemp.createTemp();
                            final imagePath = '${directory.path}/qrcode.png';
                            final file = File(imagePath)..writeAsBytesSync(image);

                            await Share.shareXFiles(
                              [XFile(file.path)],
                              text: "Here is your QR code!",
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Error sharing QR code."),
                            ),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.share),
                    label: const Text("Share QR Code"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
