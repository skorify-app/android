import 'package:flutter/material.dart';
import 'package:skorify/components/questions/color_indication_text.dart';

class QuestionColorsIndication extends StatelessWidget {
  const QuestionColorsIndication({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ColorIndicationText(text: 'Sudah Dijawab', colorCode: 0xFF4CAF50),
          const SizedBox(height: 8),
          ColorIndicationText(text: 'Ragu-ragu', colorCode: 0xFFFFD700),
          const SizedBox(height: 8),
          ColorIndicationText(text: 'Belum Dijawab', colorCode: 0xFFE0E0E0),
        ],
      ),
    );
  }
}
