import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: _isVisible,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'Waktu tersisa 0:38:00',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: const Text(
            'Sembunyikan',
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
