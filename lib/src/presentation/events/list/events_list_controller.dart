import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/common/utils/debouncer.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/data/sources/event_data_source.dart";
import "package:aplikacja_explore/src/presentation/events/list/events_list_screen.dart";
import "package:flutter/material.dart";

class EventsListController extends Controller<EventsListScreen> {
  final eventDataSource = inject<EventDataSource>();

  late final DataStateStream<List<EventModel>> sliderEvents = eventDataSource.getSlider();
  late DataStateStream<List<EventModel>> eventsList = eventDataSource.getLatest();

  final ValueNotifier<bool> isSearchBarVisible = ValueNotifier<bool>(false);
  final TextEditingController searchBarController = TextEditingController();
  final FocusNode searchBarFocusNode = FocusNode();
  final Debouncer searchDebouncer = Debouncer(duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();

    searchBarController.addListener(() {
      searchDebouncer.run(_onSearchChanged);
    });
  }

  void _onSearchChanged() {
    eventsList = eventDataSource.search(searchBarController.text);
    notifyListeners();
  }

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
}
