import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.icon,
    required this.label,
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  final String label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 62,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 62,
                height: 62,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFFDAE7E8),
                  ),
                  child: Align(
                    child: SizedBox(
                      width: 32,
                      child: icon,
                    ),
                  ),
                ),
              ),
              const VSpace(4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTypography.eventDetailsActionButton.copyWith(
                  color: const Color(0xFF3C3C3B).withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
