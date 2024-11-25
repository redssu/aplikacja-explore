import "package:flutter/services.dart";

enum HapticFeedbackForce {
  none,
  light,
  medium,
  heavy,
  selection,
  vibrate;

  void invoke() {
    switch (this) {
      case HapticFeedbackForce.none:
        return;
      case HapticFeedbackForce.light:
        HapticFeedback.lightImpact();
      case HapticFeedbackForce.medium:
        HapticFeedback.mediumImpact();
      case HapticFeedbackForce.heavy:
        HapticFeedback.heavyImpact();
      case HapticFeedbackForce.selection:
        HapticFeedback.selectionClick();
      case HapticFeedbackForce.vibrate:
        HapticFeedback.vibrate();

      default:
        throw UnimplementedError();
    }
  }
}
