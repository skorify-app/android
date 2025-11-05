import 'package:flutter/material.dart';

class QuestionNumber extends StatelessWidget {
  const QuestionNumber({super.key, required this.number});

  final String number;

  @override
  Widget build(BuildContext ctx) {
    return Row(
      children: [
        const Text(
          'Soal No ',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF2C3E50),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
