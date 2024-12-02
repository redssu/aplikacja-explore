import "dart:convert";

import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/data/sources/event_data_source.dart";
import "package:flutter/services.dart";

class EventAssetDataSource implements EventDataSource {
  late Future<List<EventModel>> _eventsFuture;

  EventAssetDataSource() {
    _eventsFuture = _loadData();
  }

  Future<List<EventModel>> _loadData() async {
    final json = await rootBundle.loadString("assets/data/events.json");

    return List<EventModel>.from(
      (jsonDecode(json) as List).map(
        (e) => EventModel.fromJson(e as Map<String, dynamic>),
      ),
    );
  }

  @override
  DataStateStream<EventModel> get(int id) async* {
    yield DataState.loading();

    await Future.delayed(const Duration(seconds: 3));
    final events = await _eventsFuture;

    yield DataState.received(events.firstWhere((e) => e.id == id));
  }

  @override
  DataStateStream<List<EventModel>> getLatest() async* {
    yield DataState.loading();

    await Future.delayed(const Duration(seconds: 3));

    final events = List<EventModel>.from(await _eventsFuture);
    events.sort((a, b) => b.dateTimeStart.compareTo(a.dateTimeStart));

    yield DataState.received(events);
  }

  @override
  DataStateStream<List<EventModel>> getSlider() async* {
    yield DataState.loading();

    await Future.delayed(const Duration(seconds: 3));
    final events = await _eventsFuture;

    yield DataState.received(events.where((e) => [6, 7].contains(e.id)).toList());
  }

  @override
  DataStateStream<List<EventModel>> search(String? query, EventsActiveFiltersData? filters) async* {
    yield DataState.loading();

    await Future.delayed(const Duration(seconds: 3));
    final events = await _eventsFuture;

    final queryLowerCase = query?.trim().toLowerCase();
    final filteredEvents = List<EventModel>.from(events);

    if (queryLowerCase != null && queryLowerCase.isNotEmpty) {
      filteredEvents.retainWhere((e) => e.title.toLowerCase().contains(queryLowerCase));
    }

    if (filters != null) {
      if (filters.eventCategories.isNotEmpty) {
        filteredEvents.retainWhere((e) => filters.eventCategories.any((ec) => e.category.id == ec.id));
      }

      if (filters.eventTargetGroups.isNotEmpty) {
        filteredEvents.retainWhere(
          (e) => e.targetGroup == null || filters.eventTargetGroups.any((etg) => e.targetGroup!.id == etg.id),
        );
      }

      if (filters.eventTypes.isNotEmpty) {
        filteredEvents.retainWhere((e) => filters.eventTypes.any((et) => e.type.id == et.id));
      }

      if (filters.distance != null) {
        // TODO: Pobieranie lokalizacji użytkownika, obliczanie odległości między użytkownikiem a wydarzeniem
        // TODO: Filtrowanie po odległości
        // filteredEvents.retainWhere((e) => e.distance <= filters.distance!);
      }
    }

    yield DataState.received(filteredEvents);
  }
}
