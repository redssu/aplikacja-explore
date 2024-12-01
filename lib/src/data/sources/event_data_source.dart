import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_category_model.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/data/models/event_target_group_model.dart";
import "package:aplikacja_explore/src/data/models/event_type_model.dart";

abstract class EventDataSource {
  DataStateStream<EventModel> get(int id);

  DataStateStream<List<EventModel>> getLatest();

  DataStateStream<List<EventModel>> getSlider();

  DataStateStream<List<EventModel>> search(String query);
}

class EventsActiveFiltersData {
  List<EventCategoryModel> eventCategories = [];
  List<EventTargetGroupModel> eventTargetGroups = [];
  List<EventTypeModel> eventTypes = [];
  double? distance;
}
