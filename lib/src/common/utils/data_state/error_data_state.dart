part of "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";

class ErrorDataState<T> implements DataState<T> {
  final Object? error;

  const ErrorDataState(this.error);
}
