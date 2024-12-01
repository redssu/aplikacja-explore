import "dart:convert";

import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/dtos/event_category_with_subcategories_dto.dart";
import "package:aplikacja_explore/src/data/models/event_category_model.dart";
import "package:aplikacja_explore/src/data/sources/event_category_data_source.dart";
import "package:flutter/services.dart";

class EventCategoryAssetDataSource implements EventCategoryDataSource {
  late Future<List<EventCategoryModel>> _eventCategoriesFuture;

  EventCategoryAssetDataSource() {
    _eventCategoriesFuture = _loadData();
  }

  Future<List<EventCategoryModel>> _loadData() async {
    final json = await rootBundle.loadString("assets/data/event_categories.json");

    return List<EventCategoryModel>.from(
      (jsonDecode(json) as List).map(
        (e) => EventCategoryModel.fromJson(e as Map<String, dynamic>),
      ),
    );
  }

  @override
  DataStateStream<List<EventCategoryModel>> getHierarchy() async* {
    yield DataState.loading();

    // await Future.delayed(const Duration(seconds: 1));
    final eventCategories = await _eventCategoriesFuture;

    // Wspiera tylko jeden poziom podkategorii
    yield DataState.received(
      eventCategories.where((e) => e.parentCategoryId == null).map((category) {
        final subcategories = eventCategories.where((e) => e.parentCategoryId == category.id).toList();

        if (subcategories.isEmpty) {
          return category;
        }

        return EventCategoryWithSubcategoriesDto.fromCategory(
          category: category,
          subcategories: subcategories,
        );
      }).toList(),
    );
  }
}
