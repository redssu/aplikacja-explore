import "dart:async";

import "package:aplikacja_explore/src/common/utils/haptic_feedback_force.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/services.dart";

typedef InteractionInfo = ({bool isBeingTapped, bool isLoading});

class InteractiveBuilder extends StatefulWidget {
  const InteractiveBuilder({
    this.builder,
    this.onTap,
    this.child,
    this.enableInteractions = true,
    this.hapticFeedbackForce = HapticFeedbackForce.none,
    super.key,
  }) : assert(builder != null || child != null);

  final Widget Function(BuildContext, InteractionInfo, Widget?)? builder;
  final FutureOr<void> Function()? onTap;
  final bool enableInteractions;
  final HapticFeedbackForce hapticFeedbackForce;
  final Widget? child;

  @override
  State<InteractiveBuilder> createState() => _InteractiveBuilderState();
}

class _InteractiveBuilderState extends State<InteractiveBuilder> {
  bool _isBeingTapped = false;
  bool _isLoading = false;

  void _onTap() {
    if (widget.onTap != null && !_isLoading) {
      final result = widget.onTap!();

      if (result is Future) {
        setState(() {
          _isLoading = true;
        });

        result.whenComplete(() {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        });
      }

      return;
    }
  }

  void _onPointerDown(_) {
    if (!widget.enableInteractions) return;

    widget.hapticFeedbackForce.invoke();

    setState(() {
      _isBeingTapped = true;
    });
  }

  void _onPointerUp(_) {
    if (!widget.enableInteractions) return;

    widget.hapticFeedbackForce.invoke();

    setState(() {
      _isBeingTapped = false;
    });
  }

  void _onPointerCancel(_) {
    if (!widget.enableInteractions) return;

    widget.hapticFeedbackForce.invoke();

    setState(() {
      _isBeingTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: GestureDetector(
        onTap: _onTap,
        child: widget.builder == null
            ? widget.child!
            : widget.builder!(
                context,
                (isBeingTapped: _isBeingTapped, isLoading: _isLoading),
                widget.child,
              ),
      ),
    );
  }
}
