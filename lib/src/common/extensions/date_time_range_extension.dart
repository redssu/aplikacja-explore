import "package:flutter/material.dart";

extension DateTimeRangeExtension on DateTimeRange {
  String get formattedDates {
    if (start.day == end.day && start.month == end.month && start.year == end.year) {
      return "${end.day}.${end.month.toString().padLeft(2, "0")}.${end.year} r.";
    }

    if (start.day != end.day && start.month == end.month && start.year == end.year) {
      return "${start.day}-${end.day}.${end.month.toString().padLeft(2, "0")}.${end.year} r.";
    }

    if (start.month != end.month && start.year == end.year) {
      return "${start.day}.${start.month.toString().padLeft(2, "0")}-${end.day}.${end.month.toString().padLeft(2, "0")}.${end.year} r.";
    }

    return "${start.day}.${start.month.toString().padLeft(2, "0")}.${start.year} r. - ${end.day}.${end.month.toString().padLeft(2, "0")}.${end.year} r.";
  }
}
