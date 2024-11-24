import "dart:async";

import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:flutter/material.dart";

typedef DataStateBuilder<T> = Widget Function(BuildContext context, DataState<T> dataState);

class DataStateStreamBuilder<T> extends StatefulWidget {
  DataStateStreamBuilder({
    required DataStateStream<T> dataStateStream,
    required this.builder,
    super.key,
  }) : dataStateStream = dataStateStream.asBroadcastStream();

  final DataStateStream<T> dataStateStream;
  final DataStateBuilder<T> builder;

  @override
  State<DataStateStreamBuilder<T>> createState() => _DataStateStreamBuilderState<T>();
}

class _DataStateStreamBuilderState<T> extends State<DataStateStreamBuilder<T>> {
  late final StreamSubscription? _subscription;

  DataState<T> _currentDataState = DataState.loading();

  @override
  void initState() {
    super.initState();

    _subscription = widget.dataStateStream.listen(_onStreamData, onError: _onStreamError, cancelOnError: true);
  }

  void _onStreamData(DataState<T> dataState) {
    setState(() {
      _currentDataState = dataState;
    });
  }

  void _onStreamError(Object error) {
    setState(() {
      _currentDataState = DataState.error(error);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _currentDataState);
}
