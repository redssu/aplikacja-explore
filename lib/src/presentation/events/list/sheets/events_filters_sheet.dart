import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/consts/app_styles.dart";
import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/layouts/sheet_layout.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/utils/default_data_state_publisher_builder.dart";
import "package:aplikacja_explore/src/common/widgets/app_button.dart";
import "package:aplikacja_explore/src/common/widgets/edge_padding.dart";
import "package:aplikacja_explore/src/common/widgets/h_space.dart";
import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:aplikacja_explore/src/data/dtos/event_category_with_subcategories_dto.dart";
import "package:aplikacja_explore/src/data/sources/event_data_source.dart";
import "package:aplikacja_explore/src/presentation/events/list/sheets/events_filters_controller.dart";
import "package:aplikacja_explore/src/presentation/events/list/sheets/widgets/events_filters_list_tile.dart";
import "package:flutter/material.dart";

class EventsFiltersSheet extends StatefulWidget {
  const EventsFiltersSheet({
    this.activeFilters,
    super.key,
  });

  final EventsActiveFiltersData? activeFilters;

  static Future<EventsActiveFiltersData?> open(BuildContext context, {EventsActiveFiltersData? activeFilters}) async {
    return showModalBottomSheet<EventsActiveFiltersData>(
      context: context,
      isScrollControlled: true,
      barrierColor: const Color(0xFFDCDCDC),
      backgroundColor: const Color(0xFFFAF9F9),
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (_) => EventsFiltersSheet(activeFilters: activeFilters),
    );
  }

  @override
  State<EventsFiltersSheet> createState() => _EventsFiltersSheetState();
}

class _EventsFiltersSheetState extends ControlledState<EventsFiltersSheet> {
  @override
  final EventsFiltersController controller = inject<EventsFiltersController>();

  @override
  Widget build(BuildContext context) {
    return SheetLayout(
      edgePadding: const EdgeInsets.only(left: 17, right: 20),
      title: "Filtry",
      onPop: controller.onCloseButtonTapped,
      child: EdgePadding(
        left: 17,
        right: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultDataStatePublisherBuilder(
              dataStatePublisher: controller.availableFiltersPublisher,
              builder: (context, availableFilters) {
                return Column(
                  children: [
                    // MARK: Kategorie wydarzeń
                    for (final category in availableFilters.eventCategories) ...[
                      const Divider(),
                      EventsFiltersListTile(
                        title: category.name,
                        isSelected: controller.isCategorySelected(category),
                        onChanged: controller.onCategoryChanged(category),
                        children: [
                          if (category is EventCategoryWithSubcategoriesDto)
                            for (final subcategory in category.subcategories) ...[
                              Divider(
                                height: 1,
                                color: const Color(0xFF4D4C4C).withOpacity(0.07),
                              ),
                              EventsFiltersListTile(
                                title: subcategory.name,
                                isSubtile: true,
                                isSelected: controller.isCategorySelected(subcategory),
                                onChanged: controller.onCategoryChanged(subcategory),
                              ),
                            ],
                        ],
                      ),
                    ],
                    //
                    Divider(color: AppStyles.primaryColor.withOpacity(0.4)),
                    // MARK: Rodzaj wydarzenia
                    EventsFiltersListTile(
                      title: "Rodzaj wydarzenia",
                      isSelected: controller.areAllEventTypesSelected,
                      onChanged: controller.onAllEventTypesTapped,
                      children: [
                        for (final eventType in availableFilters.eventTypes) ...[
                          Divider(
                            height: 1,
                            color: const Color(0xFF4D4C4C).withOpacity(0.07),
                          ),
                          EventsFiltersListTile(
                            title: eventType.name,
                            isSubtile: true,
                            isSelected: controller.isEventTypeSelected(eventType),
                            onChanged: controller.onEventTypeChanged(eventType),
                          ),
                        ],
                      ],
                    ),
                    //
                    Divider(color: AppStyles.primaryColor.withOpacity(0.4)),
                    // MARK: Grupy docelowe
                    EventsFiltersListTile(
                      title: "Według wieku",
                      isSelected: controller.areAllEventTargetGroupsSelected,
                      onChanged: controller.onAllEventTargetGroupsTapped,
                      children: [
                        for (final eventTargetGroup in availableFilters.eventTargetGroups) ...[
                          const Divider(),
                          EventsFiltersListTile(
                            title: eventTargetGroup.name,
                            isSubtile: true,
                            isSelected: controller.isEventTargetGroupSelected(eventTargetGroup),
                            onChanged: controller.onEventTargetGroupChanged(eventTargetGroup),
                          ),
                        ],
                      ],
                    ),
                    //
                    Divider(color: AppStyles.primaryColor.withOpacity(0.4)),
                  ],
                );
              },
            ),
            //
            const VSpace(45),
            // MARK: Odległość
            Text(
              "Szukaj w odległości od swojej lokalizacji",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.normal,
                color: const Color(0xFF3C3C3B).withOpacity(0.7),
                fontSize: 12,
                height: 20 / 12,
              ),
            ),
            const VSpace(8),
            const Divider(),
            const VSpace(38),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${controller.minDistance}km",
                  style: AppTypography.sliderMinMaxValueLabel.copyWith(
                    color: const Color(0xFF3C3C3B).withOpacity(0.7),
                  ),
                ),
                Text(
                  "${controller.maxDistance}km",
                  style: AppTypography.sliderMinMaxValueLabel.copyWith(
                    color: const Color(0xFF3C3C3B).withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const VSpace(4),
            Slider(
              value: controller.distance,
              onChanged: controller.onDistanceChanged,
              min: controller.minDistance,
              max: controller.maxDistance,
              divisions: controller.distanceSteps,
              label: "${controller.distance.round()}km",
            ),
            const VSpace(73),
            const Divider(),
            const VSpace(20),
            //
            const Spacer(),
            // MARK: Akcje
            Row(
              children: [
                AppButton.transparent(
                  text: "Wyczyść",
                  onTap: controller.onClearFiltersTapped,
                ),
                const Spacer(),
                AppButton.primary(
                  text: "Pokaż wyniki (${controller.resultsCount})",
                  onTap: controller.onShowResultsTapped,
                ),
                const HSpace(20),
              ],
            ),
            const VSpace(47),
          ],
        ),
      ),
    );
  }
}
