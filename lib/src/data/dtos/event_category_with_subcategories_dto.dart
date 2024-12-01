import "package:aplikacja_explore/src/data/models/event_category_model.dart";

class EventCategoryWithSubcategoriesDto extends EventCategoryModel {
  final List<EventCategoryModel> subcategories;

  EventCategoryWithSubcategoriesDto({
    required super.id,
    super.parentCategoryId,
    required super.name,
    this.subcategories = const [],
  });

  factory EventCategoryWithSubcategoriesDto.fromCategory({
    required EventCategoryModel category,
    required List<EventCategoryModel> subcategories,
  }) {
    return EventCategoryWithSubcategoriesDto(
      id: category.id,
      parentCategoryId: category.parentCategoryId,
      name: category.name,
      subcategories: subcategories,
    );
  }
}
