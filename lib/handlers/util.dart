String padToTwoDigits(int n) => n.toString().padLeft(2, '0');

String formatTime(int totalSeconds) {
  Duration duration = Duration(seconds: totalSeconds);

  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  return '${padToTwoDigits(hours)}:${padToTwoDigits(minutes)}:${padToTwoDigits(seconds)}';
}
