import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/presentation/events/single/sheets/event_add_to_calendar_sheet.dart";
import "package:flutter/material.dart";

class EventAddToCalendarController extends Controller<EventAddToCalendarSheet> {
  // TODO: Uzupełnianie danych o wydarzeniu

  void onCloseButtonTapped() {
    Navigator.of(context).pop();
  }

  void onAddButtonTapped() {
    // TODO: Dodawanie wydarzenia do kalendarza
  }
}
