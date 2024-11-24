import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class StandardBottomBar extends StatelessWidget {
  const StandardBottomBar({
    super.key,
  });

  static final List<_BottomBarItem> _items = [
    _BottomBarItem(
      icon: SvgPicture.asset("assets/icons/home-outline.svg"),
      activeIcon: SvgPicture.asset("assets/icons/home-full.svg"),
      label: "Śląskie.",
      onTap: () {
        //
      },
    ),
    _BottomBarItem(
      icon: SvgPicture.asset("assets/icons/news-outline.svg"),
      activeIcon: SvgPicture.asset("assets/icons/news-full.svg"),
      label: "Aktualności",
      onTap: () {
        //
      },
    ),
    _BottomBarItem(
      icon: SvgPicture.asset("assets/icons/calendar-outline.svg"),
      activeIcon: SvgPicture.asset("assets/icons/calendar-full.svg"),
      label: "Wydarzenia",
      onTap: () {
        //
      },
    ),
    _BottomBarItem(
      icon: SvgPicture.asset("assets/icons/explore-outline.svg"),
      activeIcon: SvgPicture.asset("assets/icons/explore-full.svg"),
      label: "Eksploruj",
      onTap: () {
        //
      },
    ),
  ];

  _BottomBarItem get _currentlySelected => _items[2];

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFE4ECED),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              for (final item in _items)
                Expanded(
                  child: GestureDetector(
                    onTap: item.onTap,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (item == _currentlySelected) item.activeIcon else item.icon,
                        const VSpace(13),
                        Text(
                          item.label,
                          style: AppTypography.bottomBarItemLabel.copyWith(
                            color: const Color(0xFF4D4C4C),
                            fontWeight: item == _currentlySelected ? FontWeight.w900 : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBarItem {
  final SvgPicture icon;
  final SvgPicture activeIcon;
  final String label;
  final VoidCallback? onTap;

  const _BottomBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.onTap,
  });
}
