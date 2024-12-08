import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/consts/app_styles.dart";
import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/utils/default_data_state_publisher_builder.dart";
import "package:aplikacja_explore/src/common/consts/app_grid.dart";
import "package:aplikacja_explore/src/common/widgets/edge_padding.dart";
import "package:aplikacja_explore/src/common/widgets/standard_app_bar.dart";
import "package:aplikacja_explore/src/common/widgets/standard_bottom_bar.dart";
import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:aplikacja_explore/src/presentation/events/list/events_list_controller.dart";
import "package:aplikacja_explore/src/presentation/events/list/widgets/events_filters.dart";
import "package:aplikacja_explore/src/presentation/events/list/widgets/events_list.dart";
import "package:aplikacja_explore/src/presentation/events/list/widgets/events_slider.dart";
import "package:flutter/material.dart";

class EventsListScreen extends StatefulWidget {
  const EventsListScreen({super.key});

  @override
  State<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends ControlledState<EventsListScreen> {
  @override
  final EventsListController controller = inject<EventsListController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        bottomNavigationBar: const StandardBottomBar(),
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VSpace(12),
              EdgePadding.gridDefined(
                child: StandardAppBar(
                  showBackButton: true,
                  title: "Wydarzenia",
                  actions: [
                    StandardAppBarAction(
                      icon: "assets/icons/search.svg",
                      semanticsLabel: "Wyszukaj",
                      onTap: controller.onSearchButtonTapped,
                    ),
                    StandardAppBarAction(
                      icon: "assets/icons/filter.svg",
                      semanticsLabel: "Otwórz kartę filtrów",
                      onTap: controller.onFilterButtonTapped,
                    ),
                  ],
                ),
              ),
              //
              const VSpace(10),
              // MARK: Wyszukiwarka
              ValueListenableBuilder(
                valueListenable: controller.isSearchBarVisible,
                builder: (context, isSearchBarVisible, _) {
                  if (!isSearchBarVisible) {
                    return const SizedBox();
                  }

                  return EdgePadding.gridDefined(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Semantics(
                        textField: true,
                        label: "Wyszukaj wydarzenie",
                        child: TextField(
                          controller: controller.searchBarController,
                          focusNode: controller.searchBarFocusNode,
                          cursorColor: const Color(0xFF4D4C4C).withOpacity(0.9),
                          cursorHeight: 19,
                          style: AppTypography.searchBar,
                          decoration: AppStyles.input,
                        ),
                      ),
                    ),
                  );
                },
              ),
              //
              // MARK: Filtry
              if (controller.hasFilters) ...[
                EventsFilters(
                  filters: controller.activeFiltersData,
                  onFiltersChanged: controller.onFiltersChanged,
                ),
                const VSpace(10),
              ],
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      const VSpace(15),
                      // MARK: Slider wydarzeń
                      if (!controller.hasFilters) ...[
                        DefaultDataStatePublisherBuilder(
                          dataStatePublisher: controller.sliderEventsPublisher,
                          loadingWidget: EventsSlider.shimmer(),
                          builder: (context, sliderEvents) => EventsSlider(events: sliderEvents),
                        ),
                        const VSpace(15),
                      ],
                      //
                      // MARK: Lista wydarzeń
                      // TODO: Dodawanie wydarzeń do ulubionych
                      EdgePadding.gridDefined(
                        child: DefaultDataStatePublisherBuilder(
                          dataStatePublisher: controller.eventsListPublisher,
                          loadingWidget: EventsList.shimmer(),
                          builder: (context, latestEvents) {
                            if (latestEvents.isEmpty && controller.hasFilters) {
                              return const Center(
                                child: Text("Brak wydarzeń o podanych kryteriach", textAlign: TextAlign.center),
                              );
                            }

                            return EventsList(
                              events: latestEvents,
                              onEventTap: controller.onEventTapped,
                              favouriteEventsIds: controller.favouriteEventsIds,
                            );
                          },
                        ),
                      ),
                      //
                      const VSpace(AppGrid.margin),
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
