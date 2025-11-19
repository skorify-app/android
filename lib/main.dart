import 'package:flutter/material.dart';
import 'package:skorify/pages/activity_screen.dart';
import 'package:skorify/pages/detail_result_ump.dart';
import 'package:skorify/pages/homepages.dart';
import 'package:skorify/pages/start_screen.dart';
import 'package:skorify/pages/test_result_sains.dart';
import 'package:skorify/pages/test_result_ump.dart';
import 'pages/onboarding_pages.dart';
import 'pages/login_pages.dart';
import 'pages/register_pages.dart';
import 'pages/account_screen.dart';

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
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),

      // Halaman pertama saat aplikasi dibuka
      initialRoute: '/',

      // Semua route didefinisikan di sini
      routes: {
        '/': (context) => const StartScreen(),
        '/onboarding_page': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPages(),
        '/homepages': (context) => const HomePages(),
        '/activity': (context) => const ActivityScreen(),
        '/account': (context) => const AccountScreen(),
        '/test_result_ump': (context) => const TestResultUmp(),
        '/test_result_sains': (context) => const TestResultSains(),
        '/detail_result_ump': (context) => const DetailResultUmp(),

      },
    );
  }
}
