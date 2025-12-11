import 'package:flutter/material.dart';
import 'package:skorify/components/questions/next_button.dart';
import 'package:skorify/components/questions/previous_button.dart';
import 'package:skorify/components/questions/submit_button.dart';
import 'package:skorify/components/questions/unsure_button.dart';

class QuestionNav extends StatelessWidget {
  const QuestionNav({
    super.key,
    required this.previousQuestionMethod,
    required this.nextQuestionMethod,
    required this.submitMethod,
    required this.questionNumber,
    required this.totalQuestions,
    this.showSubmitButton,
  });

  final VoidCallback previousQuestionMethod;
  final VoidCallback nextQuestionMethod;
  final VoidCallback submitMethod;
  final int questionNumber;
  final int totalQuestions;
  final bool? showSubmitButton;

  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(59, 158, 158, 158),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PreviousButton(
            onPressed: previousQuestionMethod,
            questionNumber: questionNumber,
          ),
          UnsureButton(questionNumber: questionNumber),
          NextButton(
            onPressed: nextQuestionMethod,
            questionNumber: questionNumber,
            totalQuestions: totalQuestions,
          ),
          if (showSubmitButton == true && questionNumber == totalQuestions) ...[
            SubmitButton(onPressed: submitMethod),
          ],
        ],
      ),
    );
  }
}
