import 'package:flutter/material.dart';

class UnsureButton extends StatelessWidget {
  const UnsureButton({super.key, required this.questionNumber});

  final int questionNumber;

  @override
  Widget build(BuildContext ctx) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFD700),
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: const Text(
        'Ragu-ragu',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
      ),
    );
  }
}
