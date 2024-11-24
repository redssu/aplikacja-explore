import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/common/utils/data_state/data_state_stream_builder.dart";
import "package:flutter/material.dart";

typedef DataBuilder<T> = Widget Function(BuildContext context, T data);

class DefaultDataStateStreamBuilder<T> extends StatelessWidget {
  const DefaultDataStateStreamBuilder({
    required this.dataStateStream,
    required this.builder,
    this.loadingWidget,
    super.key,
  });

  final DataStateStream<T> dataStateStream;
  final DataBuilder<T> builder;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    return DataStateStreamBuilder(
      dataStateStream: dataStateStream,
      builder: (context, dataState) => switch (dataState) {
        ReceivedDataState(:final data) => builder(context, data),
        LoadingDataState() => loadingWidget ?? const SizedBox(),
        DataState() => const SizedBox(),
      },
    );
  }
}
