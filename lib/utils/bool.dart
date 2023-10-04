extension BoolExtension on bool {
  T? nullIfFalse<T>(T value) => this ? value : null;
}
