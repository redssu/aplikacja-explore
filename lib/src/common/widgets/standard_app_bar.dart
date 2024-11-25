import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/utils/interactive_builder.dart";
import "package:aplikacja_explore/src/common/widgets/edge_padding.dart";
import "package:aplikacja_explore/src/common/widgets/h_space.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class StandardAppBar extends StatelessWidget {
  const StandardAppBar({
    this.showBackButton,
    this.title = "",
    this.actions = const [],
    super.key,
  });

  final bool? showBackButton;
  final String title;
  final List<Widget> actions;

  void _onBackButtonPressed(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return EdgePadding.gridDefined(
      child: Row(
        children: [
          if (showBackButton ?? Navigator.of(context).canPop()) ...[
            GestureDetector(
              onTap: () => _onBackButtonPressed(context),
              child: SvgPicture.asset(
                "assets/icons/left-arrow.svg",
                width: 21,
              ),
            ),
            const HSpace(19),
          ],
          if (title.isNotEmpty)
            Text(
              title,
              style: AppTypography.appBarTitle.copyWith(
                color: const Color(0xFF313130),
              ),
            ),
          const Spacer(),
          ...actions,
        ],
      ),
    );
  }
}

class StandardAppBarAction extends StatelessWidget {
  const StandardAppBarAction({
    required this.icon,
    this.onTap,
    super.key,
  });

  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InteractiveBuilder(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.5),
        child: SvgPicture.asset(
          icon,
          width: 21,
        ),
      ),
    );
  }
}
