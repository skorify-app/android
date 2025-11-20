import 'package:flutter/material.dart';
import 'package:skorify/pages/activity_screen.dart';
import 'package:skorify/pages/detail_result_ump/detail_result_ump_inggris.dart';
import 'package:skorify/pages/detail_result_ump/detail_result_ump_ct.dart';
import 'package:skorify/pages/detail_result_ump/detail_result_ump_indonesia.dart';
import 'package:skorify/pages/detail_result_ump/detail_result_ump_mtk.dart';
import 'package:skorify/pages/detail_result_ump/detail_result_ump_sains.dart';
import 'package:skorify/pages/homepages.dart';
import 'package:skorify/pages/start_screen.dart';
import 'package:skorify/pages/test_result/test_result_ct.dart';
import 'package:skorify/pages/test_result/test_result_indonesia.dart';
import 'package:skorify/pages/test_result/test_result_inggris.dart';
import 'package:skorify/pages/test_result/test_result_mtk.dart';
import 'package:skorify/pages/test_result/test_result_sains.dart';
import 'package:skorify/pages/test_result/test_result_ump.dart';
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
        '/test_result_mtk': (context) => const TestResultMtk(),
        '/test_result_ct': (context) => const TestResultCt(),
        '/test_result_inggris': (context) => const TestResultInggris(),
        '/test_result_indonesia': (context) => const TestResultIndonesia(),
        '/detail_result_ump_mtk': (context) => const DetailResultUmpMtk(),
        '/detail_result_ump_sains': (context) => const DetailResultUmpSains(),
        '/detail_result_ump_ct': (context) => const DetailResultUmpCt(),
        '/detail_result_ump_inggris': (context) => const DetailResultUmpInggris(),
        '/detail_result_ump_indonesia': (context) => const DetailResultUmpIndonesia(),

      },
    );
  }
}
