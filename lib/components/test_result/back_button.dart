import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(ctx, '/activity'),
        child: Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            color: Color(0xFF1E293B),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}
