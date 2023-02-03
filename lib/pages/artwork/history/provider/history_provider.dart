import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/global/provider/shared_preferences_provider.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/storage/history_storage.dart';

final historyArtworksProvider = StateProvider<List<CommonIllust>>((ref) {
  var prefs = ref.read(globalSharedPreferencesProvider);
  return HistoryStorage(prefs).getHistoryIllust();
});
