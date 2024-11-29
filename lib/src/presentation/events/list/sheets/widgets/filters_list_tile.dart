import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/widgets/app_checkbox.dart";
import "package:aplikacja_explore/src/common/widgets/h_space.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class FiltersListTile extends StatefulWidget {
  const FiltersListTile({
    required this.title,
    this.isSubtile = false,
    this.isSelected = false,
    this.onTap,
    this.children = const [],
    super.key,
  });

  final String title;
  final bool isSubtile;
  final bool isSelected;
  final void Function()? onTap;

  final List<Widget> children;

  @override
  State<FiltersListTile> createState() => _FiltersListTileState();
}

class _FiltersListTileState extends State<FiltersListTile> {
  bool isExpanded = false;

  void toggleExpansion() {
    if (widget.children.isEmpty) {
      return;
    }

    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: toggleExpansion,
                behavior: HitTestBehavior.translucent,
                child: SizedBox(
                  width: 46,
                  child: widget.children.isNotEmpty
                      ? Align(
                          child: SvgPicture.asset(
                            "assets/icons/chevron-down.svg",
                            width: 12,
                          ),
                        )
                      : null,
                ),
              ),
              if (widget.isSubtile) const HSpace(19),
              Expanded(
                child: Text(
                  widget.title,
                  style: AppTypography.FiltersListTileTitle.copyWith(
                    fontWeight: widget.isSubtile ? FontWeight.normal : FontWeight.bold,
                    color: widget.isSelected || isExpanded ? const Color(0xFF0066B1) : null,
                  ),
                ),
              ),
              Align(
                child: AppCheckbox(
                  value: widget.isSelected,
                  onChanged: (_) => widget.onTap?.call(),
                ),
              ),
              const HSpace(22),
            ],
          ),
        ),
        if (isExpanded) ...widget.children,
      ],
    );
  }
}
