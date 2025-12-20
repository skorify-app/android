import 'package:flutter/material.dart';
import 'dart:async' as da;

class Timer extends StatefulWidget {
  // The duration is in seconds
  const Timer({super.key, required this.duration, required this.submitAnswers});

  final int duration;
  final VoidCallback submitAnswers;

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  bool _isVisible = true;

  String padToTwoDigits(int n) => n.toString().padLeft(2, '0');
  String formatTime(int totalSeconds) {
    Duration duration = Duration(seconds: totalSeconds);

    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '${padToTwoDigits(hours)}:${padToTwoDigits(minutes)}:${padToTwoDigits(seconds)}';
  }

  late da.Timer _timer;
  late int _remainingSeconds;
  late Color borderColor = Colors.grey.shade300;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.duration;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = da.Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          if (_remainingSeconds <= 60) {
            borderColor = Colors.red.shade300;
          }
        });
      } else {
        timer.cancel();

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext ctx) {
            Future.delayed(Duration(seconds: 4), () {
              if (ctx.mounted) {
                Navigator.of(ctx).pop();
                widget.submitAnswers();
              }
            });

            return PopScope(
              canPop: false,
              child: AlertDialog(
                backgroundColor: const Color(0xFFF5F6F8),
                title: Text('Waktu Habis'),
                content: Text('Durasi pengerjaan soal telah selesai.'),
              ),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext ctx) {
    String formattedDuration = formatTime(_remainingSeconds);
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
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              formattedDuration,
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
