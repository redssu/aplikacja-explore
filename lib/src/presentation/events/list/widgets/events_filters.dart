import "package:aplikacja_explore/src/common/consts/app_styles.dart";
import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/widgets/edge_padding.dart";
import "package:aplikacja_explore/src/common/widgets/h_space.dart";
import "package:aplikacja_explore/src/data/sources/event_data_source.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class EventsFilters extends StatelessWidget {
  const EventsFilters({
    required this.filters,
    required this.onFiltersChanged,
    super.key,
  });

  final EventsActiveFiltersData filters;
  final void Function(EventsActiveFiltersData) onFiltersChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Aktywne filtry wydarzeń",
      slider: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: EdgePadding.gridDefined(
          child: Row(
            children: [
              for (final eventCategory in filters.eventCategories) ...[
                _FilterChip(
                  label: eventCategory.name,
                  onRemoved: () {
                    onFiltersChanged(
                      filters.copyWith(
                        eventCategories: filters.eventCategories..remove(eventCategory),
                      ),
                    );
                  },
                ),
                const HSpace(9),
              ],
              for (final eventTargetGroup in filters.eventTargetGroups) ...[
                _FilterChip(
                  label: eventTargetGroup.name,
                  onRemoved: () {
                    onFiltersChanged(
                      filters.copyWith(
                        eventTargetGroups: filters.eventTargetGroups..remove(eventTargetGroup),
                      ),
                    );
                  },
                ),
                const HSpace(9),
              ],
              for (final eventType in filters.eventTypes) ...[
                _FilterChip(
                  label: eventType.name,
                  onRemoved: () {
                    onFiltersChanged(
                      filters.copyWith(
                        eventTypes: filters.eventTypes..remove(eventType),
                      ),
                    );
                  },
                ),
                const HSpace(9),
              ],
              if (filters.distance != null) ...[
                _FilterChip(
                  label: "Dystans: do ${filters.distance!.round()} km",
                  onRemoved: () {
                    onFiltersChanged(
                      filters.copyWith()..distance = null,
                    );
                  },
                ),
                const HSpace(9),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.onRemoved,
  });

  final String label;
  final void Function() onRemoved;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Aktywny filtr: $label",
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppStyles.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(44),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Semantics(
                label: "Usuń filtr: $label",
                button: true,
                onTap: onRemoved,
                child: GestureDetector(
                  onTap: onRemoved,
                  child: SvgPicture.asset(
                    "assets/icons/cross.svg",
                    width: 9,
                    height: 10,
                    excludeFromSemantics: true,
                    colorFilter: const ColorFilter.mode(Color(0xFF3C3C3B), BlendMode.srcIn),
                  ),
                ),
              ),
              const HSpace(5),
              Text(
                label,
                style: AppTypography.eventsFiltersChipLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
