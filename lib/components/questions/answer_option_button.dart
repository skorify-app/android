import 'package:flutter/material.dart';

class AnswerOptionButton extends StatefulWidget {
  const AnswerOptionButton({super.key, required this.text});

  final String text;

  @override
  State<AnswerOptionButton> createState() => _AnswerOptionButtonState();
}

class _AnswerOptionButtonState extends State<AnswerOptionButton> {
  late String text;
  Color color = Colors.grey.shade300;

  @override
  void initState() {
    super.initState();
    text = widget.text;
  }

  @override
  Widget build(BuildContext ctx) {
    return InkWell(
      onTap: () {
        setState(() {
          color = Colors.grey;
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
