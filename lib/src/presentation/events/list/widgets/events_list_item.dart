import "package:aplikacja_explore/src/common/consts/app_grid.dart";
import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/extensions/date_time_range_extension.dart";
import "package:aplikacja_explore/src/common/utils/shimmer.dart";
import "package:aplikacja_explore/src/common/widgets/h_space.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/presentation/events/list/widgets/favourite_button.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class EventsListItem extends StatelessWidget {
  const EventsListItem({
    required this.event,
    super.key,
  });

  static Widget shimmer() => const _EventsListItemShimmer();

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppGrid.fullSize,
      height: AppGrid.columns(2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFBF9F9).withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // MARK: Obraz
            SizedBox(
              width: AppGrid.columns(2),
              height: AppGrid.columns(2),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Image.asset(
                  event.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //
            const HSpace.gutter(),
            // MARK: Opis
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10.0, right: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: AppTypography.eventCardTitle.copyWith(
                              color: const Color(0xFF313130),
                            ),
                          ),
                          const HSpace(3),
                          Text(
                            event.location.shortAddress,
                            style: AppTypography.eventCardAddress.copyWith(
                              color: const Color(0xFF313130).withOpacity(0.8),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            event.dateTimeRange.formattedDates,
                            style: AppTypography.eventCardAddress.copyWith(
                              color: const Color(0xFF313130).withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //
                    const HSpace.gutter(),
                    // MARK: Akcje
                    SizedBox(
                      width: AppGrid.columns(1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const FavouriteButton(),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 3.0),
                            child: SvgPicture.asset("assets/icons/arrow-bottom-down.svg"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventsListItemShimmer extends StatelessWidget {
  const _EventsListItemShimmer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppGrid.fullSize,
      height: AppGrid.columns(2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFBF9F9).withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    ).shimmer();
  }
}
