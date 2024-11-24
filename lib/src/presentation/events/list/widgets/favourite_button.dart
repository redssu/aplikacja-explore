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
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(29),
          color: const Color(0xFFEFEFEF),
        ),
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
