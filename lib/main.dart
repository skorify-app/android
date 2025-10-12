import 'package:flutter/material.dart';
import 'package:skorify/pages/homepages.dart';
import 'pages/login_pages.dart';
import 'pages/register_pages.dart';
import 'package:skorify/background.dart';
import 'pages/setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skorify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),

      // Halaman pertama saat aplikasi dibuka
      initialRoute: '/login',

      // Semua route didefinisikan di sini
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPages(),
        '/homepages': (context) => const HomePages(),
        '/setting': (context) => const SettingPage(), 
      },
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