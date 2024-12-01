import "dart:convert";

import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_target_group_model.dart";
import "package:aplikacja_explore/src/data/sources/event_target_group_data_source.dart";
import "package:flutter/services.dart";

class EventTargetGroupAssetDataSource implements EventTargetGroupDataSource {
  List<EventTargetGroupModel> _eventTargetGroups = [];

  EventTargetGroupAssetDataSource() {
    _loadData();
  }

  Future<void> _loadData() async {
    final json = await rootBundle.loadString("assets/data/event_target_groups.json");

    _eventTargetGroups = List<EventTargetGroupModel>.from(
      (jsonDecode(json) as List).map(
        (e) => EventTargetGroupModel.fromJson(e as Map<String, dynamic>),
      ),
    );
  }

  @override
  DataStateStream<List<EventTargetGroupModel>> getAll() async* {
    yield DataState.loading();

    // await Future.delayed(const Duration(seconds: 3));

    yield DataState.received(_eventTargetGroups);
  }
}
