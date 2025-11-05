import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onPressed,
    required this.questionNumber,
  });

  final VoidCallback onPressed;
  final int questionNumber;

  @override
  Widget build(BuildContext ctx) {
    return Visibility(
      visible: questionNumber < 30 ? true : false,
      maintainSize: true,
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
            Text('Soal selanjutnya', style: TextStyle(fontSize: 11)),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward, size: 14),
          ],
        ),
      ),
    );
  }
}
