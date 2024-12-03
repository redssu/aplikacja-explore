import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/widgets/app_button.dart";
import "package:aplikacja_explore/src/common/widgets/edge_padding.dart";
import "package:aplikacja_explore/src/common/widgets/sheet_app_bar.dart";
import "package:aplikacja_explore/src/common/widgets/v_space.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/presentation/events/single/sheets/event_add_to_calendar_controller.dart";
import "package:flutter/material.dart";

class EventAddToCalendarSheet extends StatefulWidget {
  const EventAddToCalendarSheet({
    required this.event,
    super.key,
  });

  final EventModel event;

  static Future<void> open(BuildContext context, {required EventModel event}) async {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      barrierColor: const Color(0xFFDCDCDC),
      backgroundColor: const Color(0xFFFAF9F9),
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (_) => EventAddToCalendarSheet(event: event),
    );
  }

  @override
  State<EventAddToCalendarSheet> createState() => _EventAddToCalendarSheetState();
}

class _EventAddToCalendarSheetState extends ControlledState<EventAddToCalendarSheet> {
  @override
  final EventAddToCalendarController controller = inject<EventAddToCalendarController>();

  final EdgeInsets _padding = const EdgeInsets.symmetric(horizontal: 21);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            const VSpace(27),
            EdgePadding(
              left: 16,
              right: 16,
              child: SheetAppBar(
                onPop: controller.onCloseButtonTapped,
                showCloseButton: true,
                title: "Kalendarz imprez",
              ),
            ),
            const VSpace(24),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: EdgePadding(
                        left: 16,
                        right: 26,
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: _padding,
                                child: Text(
                                  widget.event.title,
                                  style: AppTypography.addToCalendarSheetTitle.copyWith(
                                    color: const Color(0xFF313130),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: const Color(0xFF4D4C4C).withOpacity(0.4),
                              ),
                              const VSpace(10),
                              Padding(
                                padding: _padding,
                                child: Text(
                                  "${widget.event.location.place}\n"
                                  "${widget.event.location.address}, ${widget.event.location.city}",
                                  style: AppTypography.addToCalendarSheetDescription.copyWith(
                                    color: const Color(0xFF313130),
                                  ),
                                ),
                              ),
                              const VSpace(13),
                              Padding(
                                padding: _padding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Wydarzenie całodniowe",
                                      style: AppTypography.addToCalendarSheetSectionTitle.copyWith(
                                        color: const Color(0xFF313130),
                                      ),
                                    ),
                                    // TODO: Switch
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: const Color(0xFF4D4C4C).withOpacity(0.4),
                              ),
                              Padding(
                                padding: _padding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Początek",
                                      style: AppTypography.addToCalendarSheetSectionItem.copyWith(
                                        color: const Color(0xFF313130),
                                      ),
                                    ),
                                    // TODO: DatePicker
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: const Color(0xFF4D4C4C).withOpacity(0.07),
                              ),
                              Padding(
                                padding: _padding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Koniec",
                                      style: AppTypography.addToCalendarSheetSectionItem.copyWith(
                                        color: const Color(0xFF313130),
                                      ),
                                    ),
                                    // TODO: DatePicker
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: const Color(0xFF4D4C4C).withOpacity(0.07),
                              ),
                              const VSpace(17),
                              Padding(
                                padding: _padding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Powtarzaj",
                                      style: AppTypography.addToCalendarSheetSectionTitle.copyWith(
                                        color: const Color(0xFF313130),
                                      ),
                                    ),
                                    // TODO: Select
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: const Color(0xFF4D4C4C).withOpacity(0.4),
                              ),
                              const VSpace(17),
                              Padding(
                                padding: _padding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Kalendarz",
                                      style: AppTypography.addToCalendarSheetSectionTitle.copyWith(
                                        color: const Color(0xFF313130),
                                      ),
                                    ),
                                    // TODO: Select
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: const Color(0xFF4D4C4C).withOpacity(0.4),
                              ),
                              Padding(
                                padding: _padding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Zaproszeni",
                                      style: AppTypography.addToCalendarSheetSectionItem.copyWith(
                                        color: const Color(0xFF313130),
                                      ),
                                    ),
                                    // TODO: DatePicker
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: const Color(0xFF4D4C4C).withOpacity(0.07),
                              ),
                              Padding(
                                padding: _padding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Alert",
                                      style: AppTypography.addToCalendarSheetSectionTitle.copyWith(
                                        color: const Color(0xFF313130),
                                      ),
                                    ),
                                    // TODO: Select
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: const Color(0xFF4D4C4C).withOpacity(0.4),
                              ),
                              Padding(
                                padding: _padding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "2. alert",
                                      style: AppTypography.addToCalendarSheetSectionItem.copyWith(
                                        color: const Color(0xFF313130),
                                      ),
                                    ),
                                    // TODO: Select
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: const Color(0xFF4D4C4C).withOpacity(0.07),
                              ),
                              const VSpace(20),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 47),
                                child: Row(
                                  children: [
                                    AppButton.transparent(
                                      text: "Anuluj",
                                      onTap: controller.onCloseButtonTapped,
                                    ),
                                    const Spacer(),
                                    AppButton.primary(
                                      text: "Dodaj",
                                      onTap: controller.onAddButtonTapped,
                                    ),
                                  ],
                                ),
                              ),
                              const VSpace(47),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
