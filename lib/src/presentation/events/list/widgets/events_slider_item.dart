import "package:aplikacja_explore/src/common/consts/app_grid.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:flutter/material.dart";

class EventsSliderItem extends StatelessWidget {
  const EventsSliderItem({
    required this.event,
    super.key,
  });

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppGrid.columns(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          event.image,
          fit: BoxFit.cover,
          width: AppGrid.columns(5),
        ),
      ),
    );
  }
}
