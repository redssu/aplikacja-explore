import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/consts/app_grid.dart";
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
import "package:flutter_svg/svg.dart";

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
    return Scaffold(
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
                  Padding(
                    padding: const EdgeInsets.all(10.5),
                    child: SvgPicture.asset(
                      "assets/icons/search.svg",
                      width: 21,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.5),
                    child: SvgPicture.asset(
                      "assets/icons/filter.svg",
                      width: 21,
                    ),
                  ),
                ],
              ),
              //
              const VSpace(35),
              // MARK: Slider wydarzeń
              DefaultDataStateStreamBuilder(
                dataStateStream: controller.sliderEvents,
                builder: (context, sliderEvents) => EventsSlider(events: sliderEvents),
              ),
              //
              const VSpace(15),
              // MARK: Lista wydarzeń
              EdgePadding.gridDefined(
                child: DefaultDataStateStreamBuilder(
                  dataStateStream: controller.latestEvents,
                  builder: (context, latestEvents) => EventsList(events: latestEvents),
                ),
              ),
              //
              const VSpace(AppGrid.margin),
            ],
          ),
        ),
      ),
    );
  }
}
