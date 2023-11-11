import 'package:flutter/material.dart';

/// Displays an unhandled error on the screen.
class CustomErrorWidget extends StatelessWidget {
  /// Displays an unhandled error on the screen.
  const CustomErrorWidget({
    super.key,
    this.error,
    this.stackTrace,
  });

  /// The error.
  final Object? error;

  /// The stack trace.
  final StackTrace? stackTrace;

  /// On tap function to show the the dialog with the error.
  void _onTap(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Column(
          children: [
            SelectableText(error.toString()),
            if (stackTrace != null) SelectableText(stackTrace.toString()),
          ],
        ),
      ),
    );
  }

  bool get _canShowDialog => error != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _canShowDialog ? () => _onTap(context) : null,
      child: Text(
        'Error',
        overflow: TextOverflow.fade,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
