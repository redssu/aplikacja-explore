import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/presentation/events/list/widgets/events_list_item.dart";
import "package:flutter/material.dart";

class EventsList extends StatelessWidget {
  const EventsList({
    required this.events,
    super.key,
  });

  final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const VSpace(10),
      itemCount: events.length,
      itemBuilder: (context, index) => EventsListItem(event: events[index]),
    );
  }
}
