import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => ScanCodePageState();
}

class ScanCodePageState extends State<ScanCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR code"),
        backgroundColor: Colors.amber.shade600,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/generate");
            },
            icon: const Icon(Icons.qr_code),
          )
        ],
      ),
      body: MobileScanner(
        //ondetect has been removed/deprecated
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            print('varad barcode found ${barcode.rawValue}');
          }

          if (image != null) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      barcodes.first.rawValue ?? "",
                    ),
                    content: Image(
                      image: MemoryImage(image),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
