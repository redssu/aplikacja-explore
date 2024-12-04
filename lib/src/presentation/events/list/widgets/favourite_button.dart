import "package:aplikacja_explore/src/common/utils/haptic_feedback_force.dart";
import "package:aplikacja_explore/src/common/utils/interactive_builder.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    this.isFavourite = false,
    this.onTap,
    super.key,
  });

  final bool isFavourite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: isFavourite ? "Usuń z ulubionych" : "Dodaj do ulubionych",
      button: true,
      onTap: onTap,
      child: InteractiveBuilder(
        onTap: onTap,
        hapticFeedbackForce: HapticFeedbackForce.light,
        builder: (context, interactions, child) {
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(29),
              color: interactions.isBeingTapped ? const Color(0xFFD7D7D7) : const Color(0xFFEFEFEF),
            ),
            child: child,
          );
        },
        child: SizedBox(
          width: 33,
          height: 33,
          child: Align(
            child: SvgPicture.asset(
              isFavourite ? "assets/icons/heart-full.svg" : "assets/icons/heart-outline.svg",
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}
