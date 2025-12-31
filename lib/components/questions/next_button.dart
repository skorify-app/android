import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onPressed,
    required this.questionNumber,
    required this.totalQuestions,
  });

  final VoidCallback onPressed;
  final int questionNumber;
  final int totalQuestions;

  @override
  Widget build(BuildContext ctx) {
    return Visibility(
      visible: questionNumber < totalQuestions ? true : false,
      maintainSize: false,
      maintainAnimation: true,
      maintainState: true,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2C3E50),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Row(
          children: [
            Text('Selanjutnya', style: TextStyle(fontSize: 11)),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward, size: 14),
          ],
        ),
      ),
    );
  }
}
