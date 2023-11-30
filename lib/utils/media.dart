import 'package:flutter/material.dart';

extension MediaContext on BuildContext {
  bool get isSmallScreen => MediaQuery.sizeOf(this).width < 600;
}
