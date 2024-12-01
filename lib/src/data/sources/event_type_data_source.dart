import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_type_model.dart";

abstract class EventTypeDataSource {
  DataStateStream<List<EventTypeModel>> getAll();
}
