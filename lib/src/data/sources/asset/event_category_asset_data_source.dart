import "dart:convert";

import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/dtos/event_category_with_subcategories_dto.dart";
import "package:aplikacja_explore/src/data/models/event_category_model.dart";
import "package:aplikacja_explore/src/data/sources/event_category_data_source.dart";
import "package:flutter/services.dart";

class EventCategoryAssetDataSource implements EventCategoryDataSource {
  List<EventCategoryModel> _eventCategories = [];

  EventCategoryAssetDataSource() {
    _loadData();
  }

  Future<void> _loadData() async {
    final json = await rootBundle.loadString("assets/data/events.json");

    _eventCategories = List<EventCategoryModel>.from(
      (jsonDecode(json) as List).map(
        (e) => EventCategoryModel.fromJson(e as Map<String, dynamic>),
      ),
    );
  }

  @override
  DataStateStream<List<EventCategoryWithSubcategoriesDto>> getHierarchy() async* {
    yield DataState.loading();

    await Future.delayed(const Duration(seconds: 1));

    yield DataState.received(
      _eventCategories
          .where((element) => element.parentCategoryId == null)
          .map(
            (e) => EventCategoryWithSubcategoriesDto(
              category: e,
              subcategories: _eventCategories.where((element) => element.parentCategoryId == e.id).toList(),
            ),
          )
          .toList(),
    );
  }
}
