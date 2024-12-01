import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_category_model.dart";

abstract class EventCategoryDataSource {
  DataStateStream<List<EventCategoryModel>> getHierarchy();
}
