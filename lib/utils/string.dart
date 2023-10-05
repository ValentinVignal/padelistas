extension StringExtension on String {
  String get camelToTitle {
    if (isEmpty) {
      return this;
    }
    return replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match[1]}')
        .trim()
        .capitalize;
  }

  String get capitalize {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}
