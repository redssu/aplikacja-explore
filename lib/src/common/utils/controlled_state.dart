import "package:flutter/widgets.dart";

abstract class ControlledState<W extends StatefulWidget> extends State<W> {
  abstract final Controller<W> controller;

  @override
  @mustCallSuper
  void initState() {
    controller.widget = widget;
    controller.state = this;
    controller.context = context;

    super.initState();
    controller.initState();

    controller.addListener(needsRebuild);
  }

  void needsRebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant W oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget != oldWidget) {
      controller.widget = widget;
    }

    controller.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.removeListener(needsRebuild);
    controller.dispose();

    super.dispose();
  }
}

abstract class Controller<W extends StatefulWidget> with ChangeNotifier {
  late final State<W> state;
  late final BuildContext context;
  late W widget;

  TickerProvider? _vsync;
  bool _disposed = false;

  @mustCallSuper
  set vsync(TickerProvider vsync) {
    _vsync = vsync;
  }

  TickerProvider get vsync {
    if (_vsync == null) {
      throw Exception("TickerProvider is not provided, but it is required by this controller.");
    }
    return _vsync!;
  }

  void initState() {}

  void didUpdateWidget(covariant W oldWidget) {}

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  @mustCallSuper
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
