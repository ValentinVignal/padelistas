import 'package:flutter/material.dart';

import '../services/env.dart';

/// Beta widget to only display the child on staging and development, and hides
/// it on production.
class BetaWidget extends StatelessWidget {
  /// Beta widget to only display the child on staging and development, and
  /// hides it on production.
  const BetaWidget({
    super.key,
    required this.child,
  });

  /// The child.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (env == Env.prod) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: ColoredBox(
              color: theme.colorScheme.error.withOpacity(.2),
              child: Text(
                'Beta',
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
