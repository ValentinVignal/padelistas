class Value<T> {
  const Value.absent()
      : value = null,
        hasValue = false;

  const Value(this.value) : hasValue = true;

  final T? value;
  final bool hasValue;
}
