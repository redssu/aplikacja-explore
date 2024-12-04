import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/widgets/h_space.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/svg.dart";

class Select extends StatelessWidget {
  const Select({
    required this.value,
    super.key,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Pole wyboru",
      button: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: AppTypography.selectValue.copyWith(
              color: const Color(0xFF3C3C3B).withOpacity(0.5),
            ),
          ),
          const HSpace(11),
          SvgPicture.asset(
            "assets/icons/chevron-up-chevron-down.svg",
          ),
        ],
      ),
    );
  }
}
