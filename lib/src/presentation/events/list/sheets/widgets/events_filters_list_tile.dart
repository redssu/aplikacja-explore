import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/widgets/app_checkbox.dart";
import "package:aplikacja_explore/src/common/widgets/h_space.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class EventsFiltersListTile extends StatefulWidget {
  const EventsFiltersListTile({
    required this.title,
    this.isSubtile = false,
    this.isSelected = false,
    this.onChanged,
    this.children = const [],
    super.key,
  });

  final String title;
  final bool isSubtile;
  final bool isSelected;
  final void Function()? onChanged;

  final List<Widget> children;

  @override
  State<EventsFiltersListTile> createState() => _EventsFiltersListTileState();
}

class _EventsFiltersListTileState extends State<EventsFiltersListTile> {
  bool isExpanded = false;

  void toggleExpansion() {
    if (widget.children.isEmpty) {
      widget.onChanged?.call();
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
                  style: AppTypography.eventsFiltersListTileTitle.copyWith(
                    fontWeight: widget.isSubtile ? FontWeight.normal : FontWeight.bold,
                    color: widget.isSelected || isExpanded ? const Color(0xFF0066B1) : null,
                  ),
                ),
              ),
              Align(
                child: AppCheckbox(
                  value: widget.isSelected,
                  onChanged: (_) => widget.onChanged?.call(),
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
