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
  late int questionNumber = widget.questionNumber;
  late IconData icon = widget.icon;

  @override
  void initState() {
    super.initState();
    setState(() {
      icon = getIcon();
    });
  }

  IconData getIcon() {
    if (unsureQuestions.contains(questionNumber)) {
      return Icons.bookmark_remove;
    } else {
      return Icons.bookmark_add;
    }
  }

  void onPress() {
    if (unsureQuestions.contains(questionNumber)) {
      unsureQuestions.remove(questionNumber);
    } else {
      unsureQuestions.add(questionNumber);
    }

    setState(() {
      icon = getIcon();
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return ElevatedButton.icon(
      onPressed: onPress,
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
