import "package:flutter/material.dart";

class AppGrid {
  static const double margin = 20;
  static const double gutter = 6;

  factory AppGrid.of(BuildContext context) {
    return AppGrid._(
      screenSize: MediaQuery.sizeOf(context),
      orientation: MediaQuery.orientationOf(context),
    );
  }

  AppGrid._({
    required this.screenSize,
    required this.orientation,
  });

  final Size screenSize;
  final Orientation orientation;

  double get fullSize => screenSize.width - 2 * margin;
  double get columnWidth => (fullSize - (5 * gutter)) / 6;

  double columns(int columns) => (columnWidth * columns) + (gutter * (columns - 1));
}
