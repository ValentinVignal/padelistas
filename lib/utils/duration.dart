extension DurationExtension on Duration {
  String get label {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    return '${hours}h${minutes.toString().padLeft(2, '0')}min';
  }
}
