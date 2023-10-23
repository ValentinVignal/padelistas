import 'dart:async';

import 'package:flutter/material.dart';

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
