import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/common/utils/data_state/data_state_publisher.dart";
import "package:aplikacja_explore/src/data/dtos/event_category_with_subcategories_dto.dart";
import "package:aplikacja_explore/src/data/models/event_category_model.dart";
import "package:aplikacja_explore/src/data/models/event_target_group_model.dart";
import "package:aplikacja_explore/src/data/models/event_type_model.dart";
import "package:aplikacja_explore/src/data/sources/event_category_data_source.dart";
import "package:aplikacja_explore/src/data/sources/event_target_group_data_source.dart";
import "package:aplikacja_explore/src/data/sources/event_type_data_source.dart";
import "package:aplikacja_explore/src/presentation/events/list/sheets/filters_sheet.dart";
import "package:flutter/material.dart";

class FiltersController extends Controller<FiltersSheet> {
  final _eventCategoryDataSource = inject<EventCategoryDataSource>();
  final _eventTypeDataSource = inject<EventTypeDataSource>();
  final _eventTargetGroupDataSource = inject<EventTargetGroupDataSource>();

  late final DataStatePublisher<AvailableFiltersData> availableFiltersPublisher;

  final double defaultDistance = 50;
  final double minDistance = 0;
  final double maxDistance = 100;
  final double distanceStep = 0.5;
  int get distanceSteps => ((maxDistance - minDistance) / distanceStep).ceil();

  double get distance => _activeFilters.distance;

  final ActiveFiltersData _activeFilters = ActiveFiltersData();

  // TODO: Dynamiczne pobieranie wyników i prezentacja ilości
  int get resultsCount => 24;

  @override
  void initState() {
    super.initState();

    availableFiltersPublisher = _loadAvailableFilters().publisher();
  }

  void updateActiveFilters() {
    notifyListeners();
    // TODO: Pobieranie wyników z debouncer'em
  }

  DataStateStream<AvailableFiltersData> _loadAvailableFilters() async* {
    yield DataState.loading();

    // TODO: Cache'owanie danych offline
    // TODO: Uogólniona metoda do orkiestracji pobierania kilkunastu danych na raz
    final eventCategoriesDSStream = _eventCategoryDataSource.getHierarchy();
    final eventTargetGroupsDSStream = _eventTargetGroupDataSource.getAll();
    final eventTypesDSStream = _eventTypeDataSource.getAll();

    late ReceivedDataState<List<EventCategoryModel>> eventCategoriesDataState;
    late ReceivedDataState<List<EventTargetGroupModel>> eventTargetGroupsDataState;
    late ReceivedDataState<List<EventTypeModel>> eventTypesDataState;

    try {
      [
        eventCategoriesDataState,
        eventTargetGroupsDataState,
        eventTypesDataState,
      ] = await Future.wait<dynamic>([
        eventCategoriesDSStream.firstWhere((state) => state is ReceivedDataState),
        eventTargetGroupsDSStream.firstWhere((state) => state is ReceivedDataState),
        eventTypesDSStream.firstWhere((state) => state is ReceivedDataState),
      ]);
    } catch (e) {
      yield DataState.error(e);
      return;
    }

    yield DataState.received(
      AvailableFiltersData(
        eventCategories: eventCategoriesDataState.data,
        eventTargetGroups: eventTargetGroupsDataState.data,
        eventTypes: eventTypesDataState.data,
      ),
    );
  }

  bool isCategorySelected(EventCategoryModel category) {
    if (category is EventCategoryWithSubcategoriesDto) {
      final subcategories = category.subcategories;

      return subcategories.every((subcategory) => _activeFilters.eventCategories.contains(subcategory));
    }

    return _activeFilters.eventCategories.contains(category);
  }

  void Function() onCategoryChanged(EventCategoryModel category) {
    return () => _onCategoryChanged(category);
  }

  void _onCategoryChanged(EventCategoryModel category) {
    if (category is EventCategoryWithSubcategoriesDto) {
      final subcategories = category.subcategories;

      if (subcategories.every((subcategory) => _activeFilters.eventCategories.contains(subcategory))) {
        _activeFilters.eventCategories.removeWhere((subcategory) => subcategories.contains(subcategory));
      } else {
        _activeFilters.eventCategories.addAll(subcategories);
      }

      updateActiveFilters();
      return;
    }

    if (_activeFilters.eventCategories.contains(category)) {
      _activeFilters.eventCategories.remove(category);
    } else {
      _activeFilters.eventCategories.add(category);
    }

    updateActiveFilters();
  }

  bool isEventTypeSelected(EventTypeModel eventType) {
    return _activeFilters.eventTypes.contains(eventType);
  }

  void Function() onEventTypeChanged(EventTypeModel eventType) {
    return () => _onEventTypeChanged(eventType);
  }

  void _onEventTypeChanged(EventTypeModel eventType) {
    if (_activeFilters.eventTypes.contains(eventType)) {
      _activeFilters.eventTypes.remove(eventType);
    } else {
      _activeFilters.eventTypes.add(eventType);
    }

    updateActiveFilters();
  }

  bool get areAllEventTypesSelected {
    if (availableFiltersPublisher.current is! ReceivedDataState<AvailableFiltersData>) {
      return false;
    }

    final availableFilters = (availableFiltersPublisher.current as ReceivedDataState<AvailableFiltersData>).data;

    return _activeFilters.eventTypes.length == availableFilters.eventTypes.length;
  }

  Future<void> onAllEventTypesTapped() async {
    if (availableFiltersPublisher.current is! ReceivedDataState<AvailableFiltersData>) {
      return;
    }

    final availableFilters = (availableFiltersPublisher.current as ReceivedDataState<AvailableFiltersData>).data;

    if (_activeFilters.eventTypes.length == availableFilters.eventTypes.length) {
      _activeFilters.eventTypes.clear();
    } else {
      _activeFilters.eventTypes = List.from(availableFilters.eventTypes);
    }

    updateActiveFilters();
  }

  bool isEventTargetGroupSelected(EventTargetGroupModel targetGroup) {
    return _activeFilters.eventTargetGroups.contains(targetGroup);
  }

  void Function() onEventTargetGroupChanged(EventTargetGroupModel targetGroup) {
    return () => _onEventTargetGroupChanged(targetGroup);
  }

  void _onEventTargetGroupChanged(EventTargetGroupModel targetGroup) {
    if (_activeFilters.eventTargetGroups.contains(targetGroup)) {
      _activeFilters.eventTargetGroups.remove(targetGroup);
    } else {
      _activeFilters.eventTargetGroups.add(targetGroup);
    }

    updateActiveFilters();
  }

  bool get areAllEventTargetGroupsSelected {
    if (availableFiltersPublisher.current is! ReceivedDataState<AvailableFiltersData>) {
      return false;
    }

    final availableFilters = (availableFiltersPublisher.current as ReceivedDataState<AvailableFiltersData>).data;

    return _activeFilters.eventTargetGroups.length == availableFilters.eventTargetGroups.length;
  }

  Future<void> onAllEventTargetGroupsTapped() async {
    if (availableFiltersPublisher.current is! ReceivedDataState<AvailableFiltersData>) {
      return;
    }

    final availableFilters = (availableFiltersPublisher.current as ReceivedDataState<AvailableFiltersData>).data;

    _activeFilters.eventTargetGroups.clear();
    if (_activeFilters.eventTargetGroups.length != availableFilters.eventTargetGroups.length) {
      _activeFilters.eventTargetGroups.addAll(availableFilters.eventTargetGroups);
    }

    updateActiveFilters();
  }

  void onDistanceChanged(double value) {
    _activeFilters.distance = value;

    updateActiveFilters();
  }

  void onClearFiltersTapped() {
    _activeFilters.eventCategories.clear();
    _activeFilters.eventTargetGroups.clear();
    _activeFilters.eventTypes.clear();
    _activeFilters.distance = defaultDistance;

    updateActiveFilters();
  }

  void onShowResultsTapped() {
    Navigator.of(context).pop(_activeFilters);
  }
}

class AvailableFiltersData {
  final List<EventCategoryModel> eventCategories;
  final List<EventTargetGroupModel> eventTargetGroups;
  final List<EventTypeModel> eventTypes;

  AvailableFiltersData({
    required this.eventCategories,
    required this.eventTargetGroups,
    required this.eventTypes,
  });
}

class ActiveFiltersData {
  List<EventCategoryModel> eventCategories;
  List<EventTargetGroupModel> eventTargetGroups;
  List<EventTypeModel> eventTypes;
  double distance;

  ActiveFiltersData({
    this.eventCategories = const [],
    this.eventTargetGroups = const [],
    this.eventTypes = const [],
    this.distance = 50,
  });
}
