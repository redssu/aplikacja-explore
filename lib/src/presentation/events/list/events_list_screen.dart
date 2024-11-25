import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/consts/app_grid.dart";
import "package:aplikacja_explore/src/common/consts/app_styles.dart";
import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/utils/default_data_state_stream_builder.dart";
import "package:aplikacja_explore/src/common/widgets/edge_padding.dart";
import "package:aplikacja_explore/src/common/widgets/standard_app_bar.dart";
import "package:aplikacja_explore/src/common/widgets/standard_bottom_bar.dart";
import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:aplikacja_explore/src/presentation/events/list/events_list_controller.dart";
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                StandardAppBar(
                  showBackButton: true,
                  title: "Wydarzenia",
                  actions: [
                    StandardAppBarAction(
                      icon: "assets/icons/search.svg",
                      onTap: controller.onSearchButtonTapped,
                    ),
                    const StandardAppBarAction(
                      icon: "assets/icons/filter.svg",
                    ),
                  ],
                ),
                //
                const VSpace(15),
                // MARK: Wyszukiwarka
                ValueListenableBuilder(
                  valueListenable: controller.isSearchBarVisible,
                  builder: (context, isSearchBarVisible, _) {
                    if (!isSearchBarVisible) {
                      return const SizedBox();
                    }

                    return EdgePadding.gridDefined(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 7.0),
                        child: TextField(
                          controller: controller.searchBarController,
                          focusNode: controller.searchBarFocusNode,
                          cursorColor: const Color(0xFF4D4C4C).withOpacity(0.9),
                          cursorHeight: 19,
                          style: AppTypography.searchBar,
                          decoration: AppStyles.searchBar,
                        ),
                      ),
                    );
                  },
                ),
                //
                const VSpace(10),
                // MARK: Slider wydarzeń
                DefaultDataStateStreamBuilder(
                  dataStateStream: controller.sliderEvents,
                  loadingWidget: EventsSlider.shimmer(),
                  builder: (context, sliderEvents) => EventsSlider(events: sliderEvents),
                ),
                //
                const VSpace(15),
                // MARK: Lista wydarzeń
                EdgePadding.gridDefined(
                  child: DefaultDataStateStreamBuilder(
                    dataStateStream: controller.eventsList,
                    loadingWidget: EventsList.shimmer(),
                    builder: (context, latestEvents) => EventsList(events: latestEvents),
                  ),
                ),
                //
                const VSpace(AppGrid.margin),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
