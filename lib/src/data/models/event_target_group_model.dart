class EventTargetGroupModel {
  final int id;
  final String name;

  EventTargetGroupModel({
    required this.id,
    required this.name,
  });

  factory EventTargetGroupModel.fromJson(Map<String, dynamic> json) {
    return EventTargetGroupModel(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }
}
