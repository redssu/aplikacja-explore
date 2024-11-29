import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/utils/controlled_state.dart";
import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/dtos/event_category_with_subcategories_dto.dart";
import "package:aplikacja_explore/src/data/sources/event_category_data_source.dart";
import "package:aplikacja_explore/src/presentation/events/list/sheets/filters_sheet.dart";
import "package:flutter/material.dart";

class FiltersController extends Controller<FiltersSheet> {
  final _eventCategoryDataSource = inject<EventCategoryDataSource>();

  late final DataStateStream<List<EventCategoryWithSubcategoriesDto>> eventCategories;

  final double defaultDistance = 50;
  final double minDistance = 0;
  final double maxDistance = 100;
  final double distanceStep = 0.5;

  int get distanceSteps => ((maxDistance - minDistance) / distanceStep).ceil();

  late ValueNotifier<double> distance = ValueNotifier<double>(defaultDistance);

  @override
  void initState() {
    super.initState();

    eventCategories = _eventCategoryDataSource.getHierarchy();
  }
}
