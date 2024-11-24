import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/data/sources/event_data_source.dart";
import "package:aplikacja_explore/src/presentation/events/list/events_list_screen.dart";

class EventsListController extends Controller<EventsListScreen> {
  final eventDataSource = inject<EventDataSource>();

  late final DataStateStream<List<EventModel>> sliderEvents = eventDataSource.getSlider();
  late final DataStateStream<List<EventModel>> latestEvents = eventDataSource.getLatest();
}
