import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_target_group_model.dart";

abstract class EventTargetGroupDataSource {
  DataStateStream<List<EventTargetGroupModel>> getAll();
}
