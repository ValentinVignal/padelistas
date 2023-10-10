import '../utils/string.dart';

enum Location {
  marinaSquare,
  ricochetSentosa,
  ricochetLaguna,
}

extension LocationExtension on Location {
  String get label => name.camelToTitle;
}
