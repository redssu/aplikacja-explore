// ignore_for_file: avoid_classes_with_only_static_members

import "dart:ui";

import "package:flutter/material.dart";

class AppGrid {
  static const double margin = 20.0;
  static const double gutter = 6.0;

  static FlutterView get _view => WidgetsBinding.instance.platformDispatcher.views.first;
  static Size get _screenSize => _view.physicalSize / _view.devicePixelRatio;

  static double get fullSize => _screenSize.width - 2 * margin;
  static double get columnWidth => (fullSize - (5 * gutter)) / 6;

  static double columns(int columns) => (columnWidth * columns) + (gutter * (columns - 1));
}
