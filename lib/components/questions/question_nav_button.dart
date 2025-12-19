import 'package:flutter/material.dart';

class QuestionNavButton extends StatelessWidget {
  const QuestionNavButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext ctx) {
    return Positioned(
      top: 10,
      right: 0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF4A90E2),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(55, 0, 0, 0),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(-2, 0),
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
