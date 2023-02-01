import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The abstract actions of [AsyncNotifier] if the [State] is [List]
abstract class AsyncListNotifier<State> {
  /// Fetch data.
  Future<State> fetch();

  /// Reload future.
  ///
  /// Will set the state to Loading.
  Future<void> reload();

  /// For pull-to-refresh.
  ///
  /// Still keep AsyncValue as Data.
  Future<void> refresh();

  /// The action for lazyload more data.
  ///
  /// Return has more data.
  Future<bool> next();
}

/// The mixin of [AsyncNotifier] if the [State] is [List]
mixin ListAsyncNotifierMixin<State> implements AsyncListNotifier<State> {
  String? nextUrl;

  bool get hasMore => nextUrl != null;

  set state(AsyncValue<State> newState);

  @override
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  @override
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}