import 'package:flutter/material.dart';
import 'pages/generate_qr.dart';
import 'pages/scan_qr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qr_scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routes: {
        "/generate": (context) => GenerateCodePage(),
        "/scan": (context) => ScanCodePage(),
      },
      initialRoute: "/scan",

    );
  }
}
