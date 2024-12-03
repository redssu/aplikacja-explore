import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/presentation/events/single/event_screen.dart";
import "package:aplikacja_explore/src/presentation/events/single/sheets/event_add_to_calendar_sheet.dart";

class EventController extends Controller<EventScreen> {
  void onAddToCalendarButtonTapped() {
    EventAddToCalendarSheet.open(context, event: widget.event);
  }
}
