extension DurationExtension on Duration {
  String get formattedDuration {
    final days = inDays;
    final hours = inHours.remainder(24);
    final minutes = inMinutes.remainder(60);
    return '$days days, $hours hours, $minutes minutes';
  }

  String get formattedDurationShort {
    final days = inDays;
    final hours = inHours.remainder(24);
    final minutes = inMinutes.remainder(60);
    return '$days d, $hours h, $minutes m';
  }

  String get formattedDurationWithSeconds {
    final days = inDays;
    final hours = inHours.remainder(24);
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);
    String formattedSeconds = seconds < 10 ? '0$seconds' : '$seconds';
    String result = '';
    if (days > 0) {
      result += '$days days, ';
    }
    return '$result$hours hours, $minutes minutes, $formattedSeconds seconds';
  }
}
