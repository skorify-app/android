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

      initialRoute: '/',

      // ================================
      //   SMOOTH PAGE TRANSITION GLOBAL
      // ================================
      onGenerateRoute: (settings) {
        Widget page = _getPage(settings.name);

        return PageRouteBuilder(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 260),
          reverseTransitionDuration: const Duration(milliseconds: 260),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    );
  }
}

// =======================================
//   SEMUA ROUTE KAMU DIPINDAH KE SINI
//   Untuk membuat animasi otomatis
// =======================================

Widget _getPage(String? route) {
  switch (route) {
    case '/':
      return const StartScreen();
    case '/onboarding_page':
      return const OnboardingPage();
    case '/login':
      return const LoginPage();
    case '/register':
      return const RegisterPages();
    case '/homepages':
      return const HomePages();
    case '/activity':
      return const ActivityScreen();
    case '/account':
      return const AccountScreen();

    // Test Result
    case '/test_result_ump':
      return const TestResultUmp();
    case '/test_result_sains':
      return const TestResultSains();
    case '/test_result_mtk':
      return const TestResultMtk();
    case '/test_result_ct':
      return const TestResultCt();
    case '/test_result_inggris':
      return const TestResultInggris();
    case '/test_result_indonesia':
      return const TestResultIndonesia();

    // Detail Result
    case '/detail_result_ump_mtk':
      return const DetailResultUmpMtk();
    case '/detail_result_ump_sains':
      return const DetailResultUmpSains();
    case '/detail_result_ump_ct':
      return const DetailResultUmpCt();
    case '/detail_result_ump_inggris':
      return const DetailResultUmpInggris();
    case '/detail_result_ump_indonesia':
      return const DetailResultUmpIndonesia();

    default:
      return const StartScreen();
  }
}
