import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/widgets/h_space.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class SheetAppBar extends StatelessWidget {
  const SheetAppBar({
    this.showCloseButton,
    this.title = "",
    this.actions = const [],
    super.key,
  });

  final bool? showCloseButton;
  final String title;
  final List<Widget> actions;

  void _onCloseButtonPressed(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showCloseButton ?? Navigator.of(context).canPop()) ...[
          GestureDetector(
            onTap: () => _onCloseButtonPressed(context),
            child: SvgPicture.asset(
              "assets/icons/cross.svg",
              width: 21,
            ),
          ),
          const HSpace(23),
        ],
        if (title.isNotEmpty)
          Text(
            title,
            style: AppTypography.appBarTitle.copyWith(
              color: const Color(0xFF313130),
            ),
          ),
      ],
    );
  }
}
