import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/utils/data_state/data_state_publisher.dart";
import "package:aplikacja_explore/src/common/utils/debouncer.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/data/sources/event_data_source.dart";
import "package:aplikacja_explore/src/presentation/events/list/events_list_screen.dart";
import "package:aplikacja_explore/src/presentation/events/list/sheets/events_filters_sheet.dart";
import "package:flutter/material.dart";

class EventsListController extends Controller<EventsListScreen> {
  final eventDataSource = inject<EventDataSource>();

  late final DataStatePublisher<List<EventModel>> sliderEventsPublisher = eventDataSource.getSlider().publisher();
  late DataStatePublisher<List<EventModel>> eventsListPublisher = eventDataSource.getLatest().publisher();

  final ValueNotifier<bool> isSearchBarVisible = ValueNotifier<bool>(false);
  final TextEditingController searchBarController = TextEditingController();
  final FocusNode searchBarFocusNode = FocusNode();
  final Debouncer searchDebouncer = Debouncer(duration: const Duration(milliseconds: 500));

  EventsActiveFiltersData activeFiltersData = EventsActiveFiltersData();

  List<int> favouriteEventsIds = [1];
  bool get hasFilters => activeFiltersData.hasFilters;

  @override
  void initState() {
    super.initState();

    searchBarController.addListener(() {
      searchDebouncer.run(_onSearchChanged);
    });
  }

  void _onSearchChanged() => getEventsWithSearchCriteria();

  void onSearchButtonTapped() {
    isSearchBarVisible.value = !isSearchBarVisible.value;

    if (isSearchBarVisible.value) {
      searchBarController.clear();
      searchBarFocusNode.requestFocus();
    }

    if (!isSearchBarVisible.value) {
      searchBarController.clear();
      searchBarFocusNode.unfocus();
    }
  }

  void onFiltersChanged(EventsActiveFiltersData filters) {
    activeFiltersData = filters;
    getEventsWithSearchCriteria();
  }

  void getEventsWithSearchCriteria() {
    eventsListPublisher = eventDataSource.search(searchBarController.text, activeFiltersData).publisher();
    notifyListeners();
  }

  Future<void> onFilterButtonTapped() async {
    activeFiltersData = (await FiltersSheet.open(context, activeFilters: activeFiltersData)) ?? activeFiltersData;
    getEventsWithSearchCriteria();
  }
}
