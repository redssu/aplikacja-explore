import "dart:convert";

import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/data/sources/event_data_source.dart";
import "package:flutter/services.dart";

class EventAssetDataSource implements EventDataSource {
  List<EventModel> _events = [];

  EventAssetDataSource() {
    _loadData();
  }

  Future<void> _loadData() async {
    // load data from assets .json file and fill _events
    final json = await rootBundle.loadString("assets/data/events.json");

    _events = List<EventModel>.from(
      (jsonDecode(json) as List).map(
        (e) => EventModel.fromJson(e as Map<String, dynamic>),
      ),
    );
  }

  @override
  DataStateStream<EventModel> get(int id) async* {
    yield DataState.loading();

    await Future.delayed(const Duration(seconds: 3));

    yield DataState.received(_events.firstWhere((e) => e.id == id));
  }

  @override
  DataStateStream<List<EventModel>> getLatest() async* {
    yield DataState.loading();

    await Future.delayed(const Duration(seconds: 3));

    final events = List<EventModel>.from(_events);
    events.sort((a, b) => b.dateTimeStart.compareTo(a.dateTimeStart));

    yield DataState.received(events);
  }

  @override
  DataStateStream<List<EventModel>> getSlider() async* {
    yield DataState.loading();

    await Future.delayed(const Duration(seconds: 3));

    yield DataState.received(_events.where((e) => [6, 7].contains(e.id)).toList());
  }

  @override
  DataStateStream<List<EventModel>> search(String query) async* {
    yield DataState.loading();

    await Future.delayed(const Duration(seconds: 3));

    final queryLowerCase = query.trim().toLowerCase();
    final events = _events
        .where(
          (e) =>
              e.title.toLowerCase().contains(queryLowerCase) ||
              e.location.shortAddress.toLowerCase().contains(queryLowerCase),
        )
        .toList();

    yield DataState.received(events);
  }
}
