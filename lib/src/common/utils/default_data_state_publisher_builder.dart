import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/common/utils/data_state/data_state_publisher.dart";
import "package:aplikacja_explore/src/common/utils/data_state/data_state_publisher_builder.dart";
import "package:flutter/material.dart";

typedef DataBuilder<T> = Widget Function(BuildContext context, T data);

class DefaultDataStatePublisherBuilder<T> extends StatelessWidget {
  const DefaultDataStatePublisherBuilder({
    required this.dataStatePublisher,
    required this.builder,
    this.loadingWidget,
    super.key,
  });

  final DataStatePublisher<T> dataStatePublisher;
  final DataBuilder<T> builder;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    return DataStatePublisherBuilder(
      dataStatePublisher: dataStatePublisher,
      builder: (context, dataState) => switch (dataState) {
        ReceivedDataState(:final data) => builder(context, data),
        LoadingDataState() => loadingWidget ?? const SizedBox(),
        DataState() => const SizedBox(),
      },
    );
  }
}
