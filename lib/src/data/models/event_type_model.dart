class EventTypeModel {
  final int id;
  final String name;

  EventTypeModel({
    required this.id,
    required this.name,
  });

  factory EventTypeModel.fromJson(Map<String, dynamic> json) {
    return EventTypeModel(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }
}
