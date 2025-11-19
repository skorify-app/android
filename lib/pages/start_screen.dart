import 'package:flutter/material.dart';
import 'package:skorify/handlers/secure_storage_service.dart';

// This "screen" will show dashboard if user is already logged in
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext ctx) {
    _sessionExist(ctx);
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  void _sessionExist(BuildContext ctx) async {
    final SecureStorageService secureStorage = getStorage();
    bool sessionExists = await secureStorage.getSession() != null;

    if (!ctx.mounted) return;

    String path = '/onboarding_page';
    if (sessionExists) {
      path = '/homepages';
    }

    Navigator.pushReplacementNamed(ctx, path);
  }
}

