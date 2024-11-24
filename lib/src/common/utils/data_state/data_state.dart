// ignore_for_file: avoid_classes_with_only_static_members

part "error_data_state.dart";
part "loading_data_state.dart";
part "received_data_state.dart";

abstract class DataState<T> {
  static LoadingDataState<T> loading<T>() => LoadingDataState<T>();
  static DataState<T> received<T>(T data) => ReceivedDataState<T>(data);
  static DataState<T> error<T>(Object? error) => ErrorDataState<T>(error);

  static const Type d = LoadingDataState;
}

typedef DataStateStream<T> = Stream<DataState<T>>;
