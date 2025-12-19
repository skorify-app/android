import 'package:flutter/material.dart';

class QuestionNumbersGrid extends StatelessWidget {
  const QuestionNumbersGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext ctx) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}
