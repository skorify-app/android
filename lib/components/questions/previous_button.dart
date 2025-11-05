import 'package:flutter/material.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    super.key,
    required this.onPressed,
    required this.questionNumber,
  });

  final VoidCallback onPressed;
  final int questionNumber;

  @override
  Widget build(BuildContext ctx) {
    return Visibility(
      visible: questionNumber > 1 ? true : false,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back, size: 14),
        label: const Text('Kembali', style: TextStyle(fontSize: 11)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2C3E50),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}
