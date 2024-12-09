import 'dart:typed_data';
import 'package:flutter/services.dart';
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
                  // below is returned another scaffold with alertdialog inside another body
                  // changing color to transparent -- as helps shows snackbar above alert
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                  body: AlertDialog(
                    title: GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(text: barcodes.first.rawValue ?? ""),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.blue,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          content: const Row(
                            children: [
                              Icon(Icons.copy_all),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(child: Text("Copied to clipboard")),
                            ],
                          ),
                        ));
                      },
                      child: Text(
                        barcodes.first.rawValue ?? "",
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    content: Image(
                      image: MemoryImage(image),
                    ),
                  ));
                });
          }
        },
      ),
    );
  }
}
