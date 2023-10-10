enum Level {
  zero(0),
  zeroPointFive(0.5),
  one(1),
  onePointFive(1.5),
  tow(2),
  towPointFive(2.5),
  three(3),
  threePointFive(3.5),
  four(4),
  fourPointFive(4.5),
  five(5),
  fivePointFive(5.5),
  six(6),
  sixPointFive(6.5),
  seven(7);

  const Level(this.value);

  factory Level.fromValue(value) {
    return Level.values.firstWhere((level) => level.value == value);
  }

  final double value;
}

extension LevelExtension on Level {
  String get label {
    switch (value) {
      case < 0:
        throw ArgumentError('Level cannot be less than 0');
      case < 3:
        return 'Beginner';
      case < 5:
        return 'Intermediate';
      case < 6:
        return 'Advanced';
      default:
        return 'Pro';
    }
  }

  String get fullLabel {
    return '$value $label';
  }
}
