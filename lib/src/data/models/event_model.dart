import "package:aplikacja_explore/src/data/models/event_category_model.dart";
import "package:aplikacja_explore/src/data/models/event_target_group_model.dart";
import "package:aplikacja_explore/src/data/models/event_type_model.dart";
import "package:aplikacja_explore/src/data/models/location_model.dart";
import "package:flutter/material.dart";

class EventModel {
  final int id;
  final String title;
  final String subtitle;
  final LocationModel location;
  final String description;
  final DateTime dateTimeStart;
  final DateTime dateTimeEnd;
  final String image;
  final String thumbnail;
  final EventCategoryModel category;
  final EventTypeModel type;
  final EventTargetGroupModel? targetGroup;
  final String? website;
  final bool isFree;

  EventModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.description,
    required this.dateTimeStart,
    required this.dateTimeEnd,
    required this.image,
    required this.thumbnail,
    required this.category,
    required this.type,
    this.targetGroup,
    this.website,
    required this.isFree,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"] as int,
      title: json["title"] as String,
      subtitle: json["subtitle"] as String,
      location: LocationModel.fromJson(json["location"] as Map<String, dynamic>),
      description: json["description"] as String,
      dateTimeStart: DateTime.parse(json["date_time_start"] as String),
      dateTimeEnd: DateTime.parse(json["date_time_end"] as String),
      image: json["image"] as String,
      thumbnail: json["thumbnail"] as String,
      category: EventCategoryModel.fromJson(json["category"] as Map<String, dynamic>),
      type: EventTypeModel.fromJson(json["type"] as Map<String, dynamic>),
      targetGroup: json["target_group"] != null
          ? EventTargetGroupModel.fromJson(json["target_group"] as Map<String, dynamic>)
          : null,
      website: json["website"] as String?,
      isFree: json["is_free"] as bool,
    );
  }

  DateTimeRange get dateTimeRange => DateTimeRange(start: dateTimeStart, end: dateTimeEnd);
}
