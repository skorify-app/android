import 'package:flutter/material.dart';

import 'package:skorify/background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: background,

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    'SKORIFY',
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.white, fontSize: 26),
                    'Aplikasi CBT Test Potensi Akademik',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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