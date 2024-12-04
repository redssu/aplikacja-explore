import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/consts/app_typography.dart";
import "package:aplikacja_explore/src/common/layouts/sheet_layout.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/widgets/app_button.dart";
import "package:aplikacja_explore/src/common/widgets/edge_padding.dart";
import "package:aplikacja_explore/src/common/widgets/select.dart";
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

  final EdgeInsets _padding = const EdgeInsets.only(left: 21, right: 18);

  @override
  Widget build(BuildContext context) {
    return SheetLayout(
      edgePadding: const EdgeInsets.only(left: 16, right: 26),
      title: "Dodaj do kalendarza",
      onPop: controller.onCloseButtonTapped,
      child: EdgePadding(
        left: 16,
        right: 26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MARK: Informacje o wydarzeniu
            Padding(
              padding: _padding,
              child: Text(
                widget.event.title,
                semanticsLabel: "Tytuł wydarzenia",
                style: AppTypography.addToCalendarSheetTitle.copyWith(
                  color: const Color(0xFF313130),
                ),
              ),
            ),
            const Divider(),
            const VSpace(10),
            Padding(
              padding: _padding,
              child: Text(
                "${widget.event.location.place}\n"
                "${widget.event.location.address}, ${widget.event.location.city}",
                semanticsLabel: "Lokalizacja wydarzenia",
                style: AppTypography.addToCalendarSheetDescription.copyWith(
                  color: const Color(0xFF313130),
                ),
              ),
            ),
            //
            const VSpace(13),
            // MARK: Data wydarzenia
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
                  SizedBox(
                    width: 40,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ValueListenableBuilder(
                        valueListenable: controller.isAllDayEvent,
                        builder: (context, isAllDayEvent, _) {
                          return Switch(
                            value: isAllDayEvent,
                            onChanged: (value) => controller.isAllDayEvent.value = value,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
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
                  const Select(value: "18.11.24 r."),
                ],
              ),
            ),
            const Divider(),
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
                  const Select(value: "19.11.24 r."),
                ],
              ),
            ),
            const Divider(),
            //
            const VSpace(17),
            // MARK: Powtarzanie
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
                  const Select(value: "Nigdy"),
                ],
              ),
            ),
            const Divider(),
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
                  const Select(value: "Dom"),
                ],
              ),
            ),
            const Divider(),
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
                  // TODO: Select
                  const Select(value: "Brak"),
                ],
              ),
            ),
            //
            const Divider(),
            // MARK: Powiadomienia
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
                  const Select(value: "W dniu wydarzenia (9.00)"),
                ],
              ),
            ),
            const Divider(),
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
                  const Select(value: "Brak"),
                ],
              ),
            ),
            const Divider(),
            const VSpace(20),
            //
            const Spacer(),
            // MARK: Akcje
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
    );
  }
}
