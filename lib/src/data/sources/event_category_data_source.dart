import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/dtos/event_category_with_subcategories_dto.dart";

abstract class EventCategoryDataSource {
  DataStateStream<List<EventCategoryWithSubcategoriesDto>> getHierarchy();
}
