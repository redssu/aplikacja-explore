import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/utils/slider/app_value_indicator_slider_shape.dart";
import "package:aplikacja_explore/src/common/utils/slider/full_width_rectangular_track_shape.dart";
import "package:aplikacja_explore/src/presentation/events/list/events_list_screen.dart";
import "package:flutter/material.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0066B1)),
        useMaterial3: true,
        sliderTheme: SliderThemeData(
          trackHeight: 3,
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
          activeTrackColor: const Color(0xFF0066B1),
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
        ),
      ),
      home: const EventsListScreen(),
    );
  }
}
