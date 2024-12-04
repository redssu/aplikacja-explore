import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/consts/app_styles.dart";
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
      title: "Aplikacja Explore",
      theme: ThemeData(
        scaffoldBackgroundColor: AppStyles.backgroundColor,
        colorScheme: AppStyles.colorScheme,
        useMaterial3: true,
        switchTheme: AppStyles.switchTheme,
        dividerTheme: AppStyles.dividerTheme,
        sliderTheme: AppStyles.sliderTheme,
      ),
      home: const EventsListScreen(),
    );
  }
}
