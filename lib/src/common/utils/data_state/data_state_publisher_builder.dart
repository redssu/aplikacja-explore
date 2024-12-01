import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:aplikacja_explore/src/common/utils/data_state/data_state_publisher.dart";
import "package:flutter/material.dart";

typedef DataStateBuilder<T> = Widget Function(BuildContext context, DataState<T> dataState);

class DataStatePublisherBuilder<T> extends StatelessWidget {
  const DataStatePublisherBuilder({
    required this.dataStatePublisher,
    required this.builder,
    super.key,
  });

  final DataStatePublisher<T> dataStatePublisher;
  final DataStateBuilder<T> builder;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: dataStatePublisher,
        builder: (context, _) => builder(context, dataStatePublisher.current),
      );
}
