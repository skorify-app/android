import 'package:flutter/material.dart';

class QuestionChoices extends StatelessWidget {
  const QuestionChoices({
    super.key,
    required this.label,
    required this.text,
    required this.emptyAnswer,
    required this.userAnswer,
    required this.isCorrect,
  });

  final String label;
  final String text;
  final bool emptyAnswer;
  final bool userAnswer;
  final bool isCorrect;

  Color _getColor() {
    if (!userAnswer && isCorrect) return Colors.green;

    if (emptyAnswer) return Colors.black;

    if (!userAnswer) return Colors.grey.shade300;

    // user answer and it is wrong
    if (!isCorrect) return Colors.red;

    // user answer and it is correct
    return Colors.green;
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: _getColor(),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
