import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/base/base_api.dart';
import 'package:pixgem/global/provider/shared_preferences_provider.dart';
import 'package:pixgem/request/http_requester.dart';
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

abstract class BaseStateNotifier<T> extends StateNotifier<T> with _BaseNotifiersMixin implements _NeedReader {
  BaseStateNotifier(super.state, {required this.ref});

  final Ref ref;

  @override
  Reader get read => ref.read;
}

abstract class BaseAsyncNotifier<State> extends AsyncNotifier<State> with _BaseNotifiersMixin {
  @override
  Reader get read => ref.read;
}

abstract class BaseAutoDisposeAsyncNotifier<State> extends AutoDisposeAsyncNotifier<State> with _BaseNotifiersMixin {
  @override
  Reader get read => ref.read;
}

abstract class BaseFamilyAsyncNotifier<State, Arg> extends FamilyAsyncNotifier<State, Arg> with _BaseNotifiersMixin {
  @override
  Reader get read => ref.read;
}

abstract class BaseAutoDisposeFamilyAsyncNotifier<State, Arg> extends AutoDisposeFamilyAsyncNotifier<State, Arg>
    with _BaseNotifiersMixin {
  @override
  Reader get read => ref.read;
}
