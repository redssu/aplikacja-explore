class EventCategoryModel {
  final int id;
  final int? parentCategoryId;
  final String name;

  EventCategoryModel({
    required this.id,
    this.parentCategoryId,
    required this.name,
  });

  factory EventCategoryModel.fromJson(Map<String, dynamic> json) {
    return EventCategoryModel(
      id: json["id"] as int,
      parentCategoryId: json["parent_category_id"] as int?,
      name: json["name"] as String,
    );
  }
}
