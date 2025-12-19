import 'package:flutter/material.dart';
import 'package:skorify/pages/questions_screen.dart';

class UnsureButton extends StatefulWidget {
  const UnsureButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.questionNumber,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final int questionNumber;

  @override
  State<UnsureButton> createState() => _UnsureButtonState();
}

class _UnsureButtonState extends State<UnsureButton> {
  late IconData icon;
  late VoidCallback onPressed = widget.onPressed;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    bool isUnsure = unsureQuestions.contains(widget.questionNumber);
    IconData icon = isUnsure ? Icons.bookmark_remove : Icons.bookmark_add;

    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFD700),
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      icon: Icon(icon),
      label: const Text('Ragu-Ragu', style: TextStyle(fontSize: 11)),
    );
  }
}
