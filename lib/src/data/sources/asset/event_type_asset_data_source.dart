import "dart:convert";

import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_type_model.dart";
import "package:aplikacja_explore/src/data/sources/event_type_data_source.dart";
import "package:flutter/services.dart";

class EventTypeAssetDataSource implements EventTypeDataSource {
  List<EventTypeModel> _eventTypes = [];

  EventTypeAssetDataSource() {
    _loadData();
  }

  Future<void> _loadData() async {
    final json = await rootBundle.loadString("assets/data/event_types.json");

    _eventTypes = List<EventTypeModel>.from(
      (jsonDecode(json) as List).map(
        (e) => EventTypeModel.fromJson(e as Map<String, dynamic>),
      ),
    );
  }

  @override
  DataStateStream<List<EventTypeModel>> getAll() async* {
    yield DataState.loading();

    // await Future.delayed(const Duration(seconds: 3));

    yield DataState.received(_eventTypes);
  }
}
