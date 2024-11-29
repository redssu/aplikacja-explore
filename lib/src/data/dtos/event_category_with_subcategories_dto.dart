import "package:aplikacja_explore/src/data/models/event_category_model.dart";

class EventCategoryWithSubcategoriesDto {
  final EventCategoryModel category;
  final List<EventCategoryModel> subcategories;

  EventCategoryWithSubcategoriesDto({
    required this.category,
    this.subcategories = const [],
  });
}
