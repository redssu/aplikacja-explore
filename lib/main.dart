import "package:aplikacja_explore/dependency_container.dart";
import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/data/models/event_model.dart";
import "package:aplikacja_explore/src/data/sources/event_data_source.dart";
import "package:aplikacja_explore/src/presentation/events/single/event_screen.dart";
import "package:flutter/material.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  final event = ((await inject<EventDataSource>().get(3).firstWhere((state) => state is ReceivedDataState<EventModel>))
          as ReceivedDataState<EventModel>)
      .data;

  runApp(
    MyApp(event: event),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.event,
    super.key,
  });

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: EventScreen(
        event: event,
      ),
    );
  }
}
