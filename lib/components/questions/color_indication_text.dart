import 'package:flutter/material.dart';

class ColorIndicationText extends StatelessWidget {
  const ColorIndicationText({
    super.key,
    required this.text,
    required this.colorCode,
  });

  final String text;
  final int colorCode;

  @override
  Widget build(BuildContext ctx) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Color(colorCode),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
