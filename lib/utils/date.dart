extension DateExtension on DateTime {
  DateTime rounded() {
    return DateTime(year, month, day);
  }

  bool isSameDayAs(DateTime other) {
    return rounded() == other.rounded();
  }
}
