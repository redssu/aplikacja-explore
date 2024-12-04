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
        switchTheme: SwitchThemeData(
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
        ),
        dividerTheme: DividerThemeData(
          color: const Color(0xFF000000).withOpacity(0.07),
          space: 0,
          thickness: 1,
        ),
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
