import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";

abstract class EventDataSource {
  DataStateStream<EventModel> get(int id);

  DataStateStream<List<EventModel>> getLatest();

  DataStateStream<List<EventModel>> getSlider();

  DataStateStream<List<EventModel>> search(String query);
}
