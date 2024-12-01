import "package:aplikacja_explore/src/common/utils/data_state/data_state.dart";
import "package:flutter/material.dart";

class DataStatePublisher<T> with ChangeNotifier {
  final DataStateStream<T> _dataStateStream;
  DataState<T> _current = DataState.loading();
  DataState<T> get current => _current;

  DataStatePublisher(this._dataStateStream) {
    _dataStateStream.listen(_onDataStateChanged);
  }

  void _onDataStateChanged(DataState<T> dataState) {
    _current = dataState;
    notifyListeners();
  }
}

extension DataStatePublisherExtension<T> on DataStateStream<T> {
  DataStatePublisher<T> publisher() => DataStatePublisher(this);
}
