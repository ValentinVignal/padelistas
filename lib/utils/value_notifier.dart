import 'dart:async';

import 'package:flutter/material.dart';

import 'value.dart';

extension ValueNotifierExtension<T> on ValueNotifier<T?> {
  Future<T> waitForValue() async {
    if (value != null) return value!;
    final completer = Completer<T>();
    void listener() {
      if (value != null) {
        completer.complete(value);
      }
    }

    addListener(listener);
    final result = await completer.future;
    removeListener(listener);
    return result;
  }
}

extension ValueValueNotifierExtension<T> on ValueNotifier<Value<T>> {
  Future<T?> waitForValue() async {
    if (value.hasValue) return value.value;
    final completer = Completer<T?>();
    void listener() {
      if (value.hasValue) {
        completer.complete(value.value);
      }
    }

    addListener(listener);
    final result = await completer.future;
    removeListener(listener);
    return result;
  }
}
