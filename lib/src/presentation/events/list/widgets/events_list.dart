import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/presentation/events/list/widgets/events_list_item.dart";
import "package:flutter/material.dart";

class EventsList extends StatelessWidget {
  const EventsList({
    required this.events,
    required this.onEventTap,
    this.favouriteEventsIds = const [],
    super.key,
  });

  static Widget shimmer() => const _EventsListShimmer();

  final List<EventModel> events;
  final void Function(EventModel) onEventTap;
  final List<int> favouriteEventsIds;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const VSpace(10),
      itemCount: events.length,
      itemBuilder: (context, index) => EventsListItem(
        event: events[index],
        onTap: () => onEventTap(events[index]),
        isFavourite: favouriteEventsIds.contains(events[index].id),
      ),
    );
  }
}

class _EventsListShimmer extends StatelessWidget {
  const _EventsListShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const VSpace(10),
      itemCount: 5,
      itemBuilder: (_, __) => EventsListItem.shimmer(),
    );
  }
}
