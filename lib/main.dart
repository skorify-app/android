import 'package:flutter/material.dart';
import 'package:skorify/pages/forgot_password_pages.dart';
import 'package:skorify/pages/homepages.dart';
import 'package:skorify/pages/questions_screen.dart';
import 'package:skorify/pages/start_screen.dart';
import 'pages/onboarding_pages.dart';
import 'pages/login_pages.dart';
import 'pages/register_pages.dart';
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
        '/setting': (context) => const SettingPage(),
        '/test/english': (context) => const QuestionsScreen(),
        '/forgot_password': (context) => const ForgotPasswordPages(),
      },
    );
  }
}
