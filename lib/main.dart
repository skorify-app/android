import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:skorify/pages/activity_screen.dart';
import 'package:skorify/pages/homepage.dart';
import 'package:skorify/pages/loading_detail_screen.dart';
import 'package:skorify/pages/start_screen.dart';
import 'pages/onboarding_page.dart';
import 'pages/login_pages.dart';
import 'pages/register_pages.dart';
import 'pages/account_screen.dart';

void main() async {
  runApp(const MyApp());

  await Hive.initFlutter();
  await Hive.openBox('storageBox');
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
          pageBuilder: (_, _, _) => page,
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
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
  if (route != null && route.startsWith('/result/')) {
    final Uri uri = Uri.parse(route);
    final String scoreId = uri.pathSegments[1];

    return LoadingDetailScreen(scoreId: scoreId);
  }

  switch (route) {
    case '/':
      return const StartScreen();
    case '/onboarding_page':
      return const OnboardingPage();
    case '/login':
      return const LoginPage();
    case '/register':
      return const RegisterPages();
    case '/homepage':
      return const HomePage();
    case '/activity':
      return const ActivityScreen();
    case '/account':
      return const AccountScreen();

    default:
      return const StartScreen();
  }
}
