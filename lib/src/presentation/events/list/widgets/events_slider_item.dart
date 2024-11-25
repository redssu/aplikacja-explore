import "package:aplikacja_explore/src/common/consts/app_grid.dart";
import "package:aplikacja_explore/src/common/utils/shimmer.dart";
import "package:aplikacja_explore/src/common/widgets/image_placeholder.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:flutter/material.dart";

class EventsSliderItem extends StatelessWidget {
  const EventsSliderItem({
    required this.event,
    super.key,
  });

  static Widget shimmer() => const _EventsSliderItemShimmer();

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppGrid.columns(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 300 / 244,
          child: Image.asset(
            event.image,
            fit: BoxFit.cover,
            width: AppGrid.columns(5),
            errorBuilder: ImagePlaceholder.errorBuilder(showText: false),
          ),
        ),
      ),
    );
  }
}

class _EventsSliderItemShimmer extends StatelessWidget {
  const _EventsSliderItemShimmer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppGrid.columns(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 300 / 244,
          child: ColoredBox(
            color: const Color(0xFFFBF9F9).withOpacity(0.8),
          ),
        ),
      ),
    ).shimmer();
  }
}
