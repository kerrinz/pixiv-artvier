import 'package:artvier/global/provider/requester_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/global/provider/shared_preferences_provider.dart';
import 'package:artvier/request/http_requester.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef Reader = T Function<T>(ProviderListenable<T> provider);

abstract class _NeedReader {
  late final Reader read;
}

mixin _BaseNotifiersMixin {
  late final Reader read;

  HttpRequester get requester => read(httpRequesterProvider);

  SharedPreferences get prefs => read(globalSharedPreferencesProvider);
}

mixin _BaseAsyncNotifiersMixin<State> {
  late final Reader read;

  HttpRequester get requester => read(httpRequesterProvider);

  SharedPreferences get prefs => read(globalSharedPreferencesProvider);

  set state(AsyncValue<State> newState);

  /// Fetch data.
  Future<State> fetch();

  /// Reload future.
  ///
  /// Will set the state to Loading.
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// For pull-to-refresh.
  ///
  /// Still keep AsyncValue as Data.
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}

abstract class BaseStateNotifier<State> extends StateNotifier<State> with _BaseNotifiersMixin implements _NeedReader {
  BaseStateNotifier(super.state, {required this.ref});

  final Ref ref;

  @override
  Reader get read => ref.read;

  update(State state) {
    this.state = state;
  }
}

abstract class BaseAsyncNotifier<State> extends AsyncNotifier<State> with _BaseAsyncNotifiersMixin<State> {
  @override
  Reader get read => ref.read;
}

abstract class BaseAutoDisposeAsyncNotifier<State> extends AutoDisposeAsyncNotifier<State>
    with _BaseAsyncNotifiersMixin<State> {
  @override
  Reader get read => ref.read;
}

abstract class BaseFamilyAsyncNotifier<State, Arg> extends FamilyAsyncNotifier<State, Arg>
    with _BaseAsyncNotifiersMixin<State> {
  @override
  Reader get read => ref.read;
}

abstract class BaseAutoDisposeFamilyAsyncNotifier<State, Arg> extends AutoDisposeFamilyAsyncNotifier<State, Arg>
    with _BaseAsyncNotifiersMixin<State> {
  @override
  Reader get read => ref.read;
}
