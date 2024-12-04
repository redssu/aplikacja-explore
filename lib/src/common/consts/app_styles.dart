// ignore_for_file: avoid_classes_with_only_static_members

import "package:aplikacja_explore/src/common/utils/slider/app_value_indicator_slider_shape.dart";
import "package:aplikacja_explore/src/common/utils/slider/full_width_rectangular_track_shape.dart";
import "package:flutter/material.dart";

class AppStyles {
  static const Color primaryColor = Color(0xFF0066B1);
  static const Color backgroundColor = Color(0xFFEFEFEF);

  static final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: primaryColor);

  static const InputDecoration input = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(35)),
      borderSide: BorderSide(color: Color(0xFF4D4C4C)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(35)),
      borderSide: BorderSide(color: Color(0xFF4D4C4C)),
    ),
  );

  static final SwitchThemeData switchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xFFFFFFFF);
      }
      return const Color(0xFF313130);
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xFF0DDEAE);
      }
      return Colors.transparent;
    }),
    trackOutlineWidth: WidgetStateProperty.all(1),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return const Color(0xFF313130);
    }),
    thumbIcon: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check, size: 16, color: Color(0xFF0DDEAE));
      }
      return null;
    }),
  );

  static final DividerThemeData dividerTheme = DividerThemeData(
    color: const Color(0xFF000000).withOpacity(0.07),
    space: 0,
    thickness: 1,
  );

  static final SliderThemeData sliderTheme = SliderThemeData(
    trackHeight: 3,
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
    activeTrackColor: AppStyles.primaryColor,
    inactiveTrackColor: const Color(0xFF000000).withOpacity(0.07),
    trackShape: FullWidthRectangularTrackShape(),
    thumbColor: const Color(0xFFFFFFFF),
    showValueIndicator: ShowValueIndicator.always,
    valueIndicatorShape: const AppValueIndicatorSliderShape(),
    valueIndicatorColor: const Color(0xFF0DDEAE),
    valueIndicatorTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: "Roboto",
      fontSize: 14,
    ),
  );
}
