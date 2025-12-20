import 'package:flutter/material.dart';
import 'package:skorify/components/test_result/question_choices.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.questionText,
    required this.choices,
    required this.correctAnswer,
    required this.userAnswer,
  });

  final String questionText;
  final List<Map<String, String>> choices;
  final String correctAnswer;
  final String userAnswer;

  @override
  Widget build(BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionText,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF1F2937),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          for (int i = 0; i < choices.length; i++)
            QuestionChoices(
              label: choices[i]['label'] ?? '',
              text: choices[i]['choice_value'] ?? '',
              emptyAnswer: userAnswer == '-1',
              userAnswer: choices[i]['label'] == userAnswer,
              isCorrect: correctAnswer == choices[i]['label'],
            ),
        ],
      ),
    );
  }
}
