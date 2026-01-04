import 'package:flutter/material.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/handlers/api/questions/submit.dart';
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/handlers/secure_storage_service.dart';
import 'package:skorify/pages/error_page.dart';

class SubmittingAnswersPage extends StatefulWidget {
  const SubmittingAnswersPage({super.key, required this.answersData});

  final AnswersData answersData;

  @override
  State<SubmittingAnswersPage> createState() => _SubmittingAnswersPageState();
}

class _SubmittingAnswersPageState extends State<SubmittingAnswersPage> {
  @override
  void initState() {
    super.initState();
    fetchQuestionsFromAPI();
  }

  Future<void> fetchQuestionsFromAPI() async {
    final SecureStorageService secureStorage = getStorage();
    String sessionId = await secureStorage.get('session') ?? '';

    List<Map<String, dynamic>> answersJson = widget.answersData.answers
        .map((answer) => answer.toJson())
        .toList();

    StringAPIResult rawResult = await submit(sessionId, {
      'type': widget.answersData.type,
      'subtestId': widget.answersData.subtestId,
      'answers': answersJson,
    });

    if (!mounted) return;

    if (!rawResult.success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ErrorPage(
            message:
                'Maaf, terjadi kesalahan pada sistem saat mencoba mengirim jawaban kamu.',
          ),
        ),
      );
      return;
    }

    String scoreId = rawResult.result;
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/result/$scoreId',
      (Route<dynamic> route) => false,
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
              'Sedang memeriksa jawaban kamu...',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
