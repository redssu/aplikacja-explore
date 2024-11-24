part of "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";

class ReceivedDataState<T> implements DataState<T> {
  final T data;

  const ReceivedDataState(this.data);
}
