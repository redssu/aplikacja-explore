import "dart:convert";

import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_target_group_model.dart";
import "package:aplikacja_explore/src/data/sources/event_target_group_data_source.dart";
import "package:flutter/services.dart";

class EventTargetGroupAssetDataSource implements EventTargetGroupDataSource {
  late Future<List<EventTargetGroupModel>> _eventTargetGroupsFuture;

  EventTargetGroupAssetDataSource() {
    _eventTargetGroupsFuture = _loadData();
  }

  Future<List<EventTargetGroupModel>> _loadData() async {
    final json = await rootBundle.loadString("assets/data/event_target_groups.json");

    return List<EventTargetGroupModel>.from(
      (jsonDecode(json) as List).map(
        (e) => EventTargetGroupModel.fromJson(e as Map<String, dynamic>),
      ),
    );
  }

  @override
  DataStateStream<List<EventTargetGroupModel>> getAll() async* {
    yield DataState.loading();

    // await Future.delayed(const Duration(seconds: 3));

    final eventTargetGroups = await _eventTargetGroupsFuture;

    yield DataState.received(eventTargetGroups);
  }
}
