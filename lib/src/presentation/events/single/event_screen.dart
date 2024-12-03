import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/consts/app_grid.dart";
import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/extensions/date_time_extension.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/widgets/edge_padding.dart";
import "package:aplikacja_explore/src/common/widgets/h_space.dart";
import "package:aplikacja_explore/src/common/widgets/image_placeholder.dart";
import "package:aplikacja_explore/src/common/widgets/standard_app_bar.dart";
import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/presentation/events/single/event_controller.dart";
import "package:aplikacja_explore/src/presentation/events/single/widgets/action_button.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class EventScreen extends StatefulWidget {
  const EventScreen({
    required this.event,
    super.key,
  });

  final EventModel event;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends ControlledState<EventScreen> {
  @override
  final EventController controller = inject<EventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const VSpace(12),
            const EdgePadding.gridDefined(
              child: StandardAppBar(showBackButton: true),
            ),
            const VSpace(16),
            Expanded(
              child: SingleChildScrollView(
                child: EdgePadding.gridDefined(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // MARK: Informacje o wydarzeniu
                      Text(
                        widget.event.title,
                        style: AppTypography.eventDetailsTitle.copyWith(
                          color: const Color(0xFF313130),
                        ),
                      ),
                      Text(
                        widget.event.subtitle,
                        style: AppTypography.eventDetailsSubtitle.copyWith(
                          color: const Color(0xFF313130),
                        ),
                      ),
                      const VSpace(5),
                      Text(
                        "${widget.event.dateTimeStart.formattedDate} | g. ${widget.event.dateTimeStart.formattedTime}",
                        style: AppTypography.eventDetailsStartDate.copyWith(
                          color: const Color(0xFF0066B1),
                        ),
                      ),
                      const VSpace(6),
                      Text(
                        "${widget.event.location.place}\n"
                        "${widget.event.location.address}, ${widget.event.location.city}",
                        style: AppTypography.eventDetailsAddress.copyWith(
                          color: const Color(0xFF313130),
                        ),
                      ),
                      const VSpace(14),
                      SizedBox(
                        width: AppGrid.fullSize - AppGrid.margin,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            widget.event.image,
                            fit: BoxFit.cover,
                            errorBuilder: ImagePlaceholder.errorBuilder(height: 300),
                          ),
                        ),
                      ),
                      //
                      const VSpace(16),
                      // MARK: Akcje
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ActionButton(
                              icon: SvgPicture.asset(
                                "assets/icons/add-to-calendar.svg",
                              ),
                              label: "Dodaj do kalendarza",
                              onTap: controller.onAddToCalendarButtonTapped,
                            ),
                          ),
                          Expanded(
                            child: ActionButton(
                              icon: SvgPicture.asset(
                                "assets/icons/share.svg",
                              ),
                              label: "Udostępnij",
                            ),
                          ),
                          Expanded(
                            child: ActionButton(
                              icon: SvgPicture.asset(
                                "assets/icons/navigate.svg",
                              ),
                              label: "Pokaż na mapie",
                            ),
                          ),
                          Expanded(
                            child: ActionButton(
                              icon: SvgPicture.asset(
                                "assets/icons/www.svg",
                              ),
                              label: "Strona www",
                            ),
                          ),
                        ],
                      ),
                      //
                      const VSpace(19),
                      // MARK: Opis
                      Text(
                        widget.event.description,
                        style: AppTypography.eventDetailsDescription.copyWith(
                          color: const Color(0xFF313130),
                        ),
                      ),
                      const VSpace(25),
                      if (widget.event.isFree)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppGrid.margin),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/free.svg"),
                              const HSpace(6),
                              Text(
                                "Wydarzenie bezpłatne",
                                style: AppTypography.eventDetailsPriceInfo.copyWith(
                                  color: const Color(0xFF313130),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const VSpace(26),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppGrid.margin),
                        child: Row(
                          children: [
                            if (widget.event.facebook != null) ...[
                              SvgPicture.asset("assets/icons/logos/facebook.svg", width: 32),
                              const HSpace(20),
                            ],
                            if (widget.event.instagram != null) ...[
                              SvgPicture.asset("assets/icons/logos/instagram.svg", width: 32),
                              const HSpace(20),
                            ],
                          ],
                        ),
                      ),
                      const VSpace(80),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
