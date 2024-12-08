// ignore_for_file: avoid_classes_with_only_static_members

import "package:aplikacja_explore/src/data/sources/asset/event_asset_data_source.dart";
import "package:aplikacja_explore/src/data/sources/asset/event_category_asset_data_source.dart";
import "package:aplikacja_explore/src/data/sources/asset/event_target_group_asset_data_source.dart";
import "package:aplikacja_explore/src/data/sources/asset/event_type_asset_data_source.dart";
import "package:aplikacja_explore/src/data/sources/event_category_data_source.dart";
import "package:aplikacja_explore/src/data/sources/event_data_source.dart";
import "package:aplikacja_explore/src/data/sources/event_target_group_data_source.dart";
import "package:aplikacja_explore/src/data/sources/event_type_data_source.dart";
import "package:aplikacja_explore/src/presentation/events/list/events_list_controller.dart";
import "package:aplikacja_explore/src/presentation/events/list/sheets/events_filters_controller.dart";
import "package:aplikacja_explore/src/presentation/events/single/event_controller.dart";
import "package:aplikacja_explore/src/presentation/events/single/sheets/event_add_to_calendar_controller.dart";

class DependenciesContainer {
  final Map<Type, dynamic> _singletons = {};
  final Map<Type, dynamic Function()> _lazySingletons = {};
  final Map<Type, dynamic Function()> _factories = {};

  void bindSingleton<T>(T instance) {
    _singletons[T] = instance;
  }

  void bindLazySingleton<T>(T Function() factory) {
    _lazySingletons[T] = factory;
  }

  void bindFactory<T>(T Function() factory) {
    _factories[T] = factory;
  }

  T get<T>() {
    if (_singletons.containsKey(T)) {
      return _singletons[T] as T;
    }

    if (_lazySingletons.containsKey(T)) {
      final instance = _lazySingletons[T]!();
      _singletons[T] = instance;

      return instance as T;
    }

    if (_factories.containsKey(T)) {
      return _factories[T]!() as T;
    }

    throw Exception("No binding found for type \"$T\"");
  }
}

final dependencyContainer = DependenciesContainer();

void setupDependencies() {
  /**
   * Źródła danych
   */
  dependencyContainer.bindLazySingleton<EventDataSource>(EventAssetDataSource.new);
  dependencyContainer.bindLazySingleton<EventCategoryDataSource>(EventCategoryAssetDataSource.new);
  dependencyContainer.bindLazySingleton<EventTargetGroupDataSource>(EventTargetGroupAssetDataSource.new);
  dependencyContainer.bindLazySingleton<EventTypeDataSource>(EventTypeAssetDataSource.new);

  /**
   * Kontrolery
   */
  dependencyContainer.bindFactory<EventsListController>(EventsListController.new);
  dependencyContainer.bindFactory<EventController>(EventController.new);
  dependencyContainer.bindFactory<EventsFiltersController>(EventsFiltersController.new);
  dependencyContainer.bindFactory<EventAddToCalendarController>(EventAddToCalendarController.new);
}

T inject<T>() => dependencyContainer.get<T>();
