import "package:aplikacja_explore/src/common/extensions/offset_extension.dart";
import "package:flutter/material.dart";

class AppGrid {
  static const double margin = 20;
  static const double gutter = 6;
  static const int columnsCount = 6;

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

  Size get fullSize => ((screenSize - const Size.square(2 * margin)) as Offset).asSize();
  Size get column =>
      ((fullSize - const Size.square((columnsCount - 1) * gutter)) as Offset).asSize() / columnsCount.toDouble();

  double columns(int columns) => _columns(columns, column.width);

  double portraitColumns(int columns) =>
      _columns(columns, orientation == Orientation.portrait ? fullSize.width : fullSize.height);

  double landscapeColumns(int columns) =>
      _columns(columns, orientation == Orientation.landscape ? fullSize.width : fullSize.height);

  double _columns(int columns, double columnWidth) => (columnWidth * columns) + (gutter * (columns - 1));
}
