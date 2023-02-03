import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/global/model/image_download_task_model/image_download_task_model.dart';

final downloadManageProvider =
    StateNotifierProvider.autoDispose<ArtworkDownloadListNotifier, List<ImageDownloadTaskModel>>((ref) {
  return ArtworkDownloadListNotifier([], ref: ref);
});

class ArtworkDownloadListNotifier extends BaseStateNotifier<List<ImageDownloadTaskModel>> {
  ArtworkDownloadListNotifier(super.state, {required super.ref});
}
