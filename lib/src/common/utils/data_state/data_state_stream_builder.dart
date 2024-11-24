import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:flutter/material.dart";

typedef DataStateBuilder<T> = Widget Function(BuildContext context, DataState<T> dataState);

class DataStateStreamBuilder<T> extends StatelessWidget {
  const DataStateStreamBuilder({
    required this.dataStateStream,
    required this.builder,
    super.key,
  });

  final DataStateStream<T> dataStateStream;
  final DataStateBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dataStateStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return builder(context, DataState.error(snapshot.error));
        }

        if (!snapshot.hasData) {
          return builder(context, DataState.loading());
        }

        return builder(context, snapshot.data!);
      },
    );
  }
}
