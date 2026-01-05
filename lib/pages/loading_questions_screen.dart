import 'package:flutter/material.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/handlers/api/questions/fetch_subtest.dart';
import 'package:skorify/handlers/api/questions/fetch_umpb.dart';
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/handlers/secure_storage_service.dart';
import 'package:skorify/pages/questions_screen.dart';

List<String> _questionTypes = ['subtest', 'umpb'];

class LoadingQuestionScreen extends StatefulWidget {
  const LoadingQuestionScreen({
    super.key,
    required this.type,
    required this.subtestId,
    required this.duration,
  });

  final String type;
  final String? subtestId;
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

  void begone() {
    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/homepage',
      (Route<dynamic> route) => false,
    );
    return;
  }

  QuestionsInfo generateQuestionInfo(List<dynamic> unformattedQuestions) {
    List<Question> questions = [];

    for (int i = 0; i < unformattedQuestions.length; i++) {
      Map<String, dynamic> rawQuestion = unformattedQuestions[i];

      List<Choice> choices = [];
      for (int j = 0; j < rawQuestion['choices'].length; j++) {
        Map<String, dynamic> rawChoice = rawQuestion['choices'][j];
        Choice choice = Choice(
          label: rawChoice['label'],
          choiceValue: rawChoice['choice_value'],
        );
        choices.add(choice);
      }

      Question question = Question(
        id: rawQuestion['question_id'],
        text: rawQuestion['question_text'],
        choices: choices,
        image: rawQuestion['image'],
      );
      questions.add(question);
    }

    QuestionsInfo result = QuestionsInfo(
      type: widget.type,
      subtestId: widget.subtestId,
      duration: widget.duration,
      questions: questions,
    );

    return result;
  }

  Future<void> fetchQuestionsFromAPI() async {
    String type = widget.type;

    if (!_questionTypes.contains(type)) return;

    final SecureStorageService secureStorage = getStorage();
    String sessionId = await secureStorage.get('session') ?? '';
    if (sessionId.isEmpty) return;

    QuestionAPIResult rawResult;
    QuestionsInfo questionsInfo;

    if (type == 'subtest') {
      String subtestId = widget.subtestId ?? '';
      if (subtestId.isEmpty) return;

      rawResult = await fetchSubtestQuestions(sessionId, subtestId);

      if (!rawResult.success) return;
    } else {
      rawResult = await fetchUMPBQuestions(sessionId);
      if (!rawResult.success) return;
    }

    questionsInfo = generateQuestionInfo(rawResult.result);

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => QuestionsScreen(questionsInfo: questionsInfo),
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
