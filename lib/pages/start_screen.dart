import 'package:flutter/material.dart';
import 'package:skorify/handlers/secure_storage_service.dart';

// Screen ini akan menentukan halaman pertama yang user lihat.
// Jika sudah masuk akun, maka akan langsung ke /homepage.
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext ctx) {
    _sessionExist(ctx);
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  void _sessionExist(BuildContext ctx) async {
    final SecureStorageService secureStorage = getStorage();
    String? sessionExists = await secureStorage.get('session');

    if (!ctx.mounted) return;

    String path = sessionExists != null ? '/homepage' : '/onboarding_page';
    Navigator.pushReplacementNamed(ctx, path);
  }
}
