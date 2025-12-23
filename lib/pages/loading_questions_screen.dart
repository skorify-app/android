import 'package:flutter/material.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/handlers/api/questions/fetch.dart';
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/handlers/secure_storage_service.dart';
import 'package:skorify/pages/questions_screen.dart';

class LoadingQuestionScreen extends StatefulWidget {
  const LoadingQuestionScreen({
    super.key,
    required this.subtestId,
    required this.duration,
  });

  final String subtestId;
  final int duration;

  @override
  State<LoadingQuestionScreen> createState() => _LoadingQuestionScreenState();
}

class _LoadingQuestionScreenState extends State<LoadingQuestionScreen> {
  @override
  void initState() {
    super.initState();
    fetchQuestionsFromAPI();
  }

  Future<void> fetchQuestionsFromAPI() async {
    final SecureStorageService secureStorage = getStorage();
    String sessionId = await secureStorage.get('session') ?? '';

    String subtestId = widget.subtestId;
    QuestionAPIResult rawResult = await fetchQuestions(sessionId, subtestId);

    if (!mounted) return;

    if (!rawResult.success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/homepage',
        (Route<dynamic> route) => false,
      );
      return;
    }

    List<QuestionData> listOfQuestions = [];
    List<dynamic> result = rawResult.result;
    for (var i = 0; i < result.length; i++) {
      Map<String, dynamic> question = result[i];

      List<Choice> choices = [];
      List<dynamic> listOfChoices = question['choices'];

      for (var j = 0; j < listOfChoices.length; j++) {
        choices.add(
          Choice(
            label: listOfChoices[j]['label'],
            choiceValue: listOfChoices[j]['choice_value'],
          ),
        );
      }

      listOfQuestions.add(
        QuestionData(
          id: question['question_id'],
          text: question['question_text'],
          choices: choices,
        ),
      );
    }

    Questions questions = Questions(
      subtestId: int.parse(subtestId),
      questions: listOfQuestions,
    );

    int duration = widget.duration * 60;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => QuestionsScreen(
          subtestId: subtestId,
          questions: questions,
          duration: duration,
        ),
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
              'Mengunduh soal-soal...',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
