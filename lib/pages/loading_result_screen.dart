import 'package:flutter/material.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/handlers/api/scores/detail.dart';
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/handlers/secure_storage_service.dart';
import 'package:skorify/pages/error_page.dart';
import 'package:skorify/pages/result_screen.dart';

class LoadingDetailScreen extends StatefulWidget {
  const LoadingDetailScreen({super.key, required this.scoreId});

  final String scoreId;

  @override
  State<LoadingDetailScreen> createState() => _LoadingDetailScreenState();
}

class _LoadingDetailScreenState extends State<LoadingDetailScreen> {
  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  void fetchDetail() async {
    final SecureStorageService secureStorage = getStorage();
    String session = await secureStorage.get('session') ?? '';
    DefaultAPIResult apiRes = await detail(session, widget.scoreId);

    if (!mounted) return;

    if (!apiRes.success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ErrorPage(
            message:
                'Maaf, terjadi kesalahan saat melihat informasi hasil pengerjaan subtes',
          ),
        ),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultScreen(scoreData: apiRes.result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      appBar: TopBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.black),
            SizedBox(height: 20),
            Text(
              'Sedang mengunduh jawaban kamu...',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
