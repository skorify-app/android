import 'package:flutter/material.dart';
import 'pages/login_pages.dart';
import 'package:skorify/background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}


/*
Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: Container(
          decoration: background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.only(left: 30.0)),
              Text(
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: 48),
                'SKORIFY',
              ),
              Text(
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: 20),
                'Aplikasi CBT Test Potensi Akademik',
              ),
            ],
          ),
        ),
      ),
    );
  }*/