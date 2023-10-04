import 'package:flutter/material.dart';

/// A page to display a dialog.
class BottomSheetPage extends Page<dynamic> {
  /// A page to display a dialog.
  const BottomSheetPage({
    required this.child,
    super.key,
  });

  /// The widget to be displayed which is usually a [Dialog] widget.
  final Widget child;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return ModalBottomSheetRoute(
      settings: this,
      builder: (context) => child,
      capturedThemes:
          InheritedTheme.capture(from: context, to: navigator.context),
      barrierLabel: localizations.scrimLabel,
      isScrollControlled: false,
      barrierOnTapHint:
          localizations.scrimOnTapHint(localizations.bottomSheetLabel),
      modalBarrierColor: Theme.of(context).bottomSheetTheme.modalBarrierColor,
    );
  }
}
