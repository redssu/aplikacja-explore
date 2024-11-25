import "package:aplikacja_explore/src/common/widgets/edge_padding.dart";
import "package:aplikacja_explore/src/common/widgets/h_space.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/presentation/events/list/widgets/events_slider_item.dart";
import "package:flutter/material.dart";

class EventsSlider extends StatelessWidget {
  const EventsSlider({
    required this.events,
    super.key,
  });

  static Widget shimmer() => const _EventsSliderShimmer();

  final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: EdgePadding.gridDefined(
        child: Row(
          children: [
            for (var index = 0; index < events.length; index++) ...[
              if (index != 0) const HSpace(10),
              EventsSliderItem(event: events[index]),
            ],
          ],
        ),
      ),
    );
  }
}

class _EventsSliderShimmer extends StatelessWidget {
  const _EventsSliderShimmer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: EdgePadding.gridDefined(
        child: Row(
          children: [
            for (var index = 0; index < 5; index++) ...[
              if (index != 0) const HSpace(10),
              EventsSliderItem.shimmer(),
            ],
          ],
        ),
      ),
    );
  }
}
