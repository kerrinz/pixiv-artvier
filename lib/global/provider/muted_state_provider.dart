import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MutedState {
  const MutedState({
    this.hasSynced = false,
    this.userIds = const <String>{},
    this.tags = const <String>{},
  });

  final bool hasSynced;
  final Set<String> userIds;
  final Set<String> tags;

  MutedState copyWith({
    bool? hasSynced,
    Set<String>? userIds,
    Set<String>? tags,
  }) {
    return MutedState(
      hasSynced: hasSynced ?? this.hasSynced,
      userIds: userIds ?? this.userIds,
      tags: tags ?? this.tags,
    );
  }

  bool containsIllust(CommonIllust illust) {
    if (!hasSynced && illust.isMuted) return true;
    if (userIds.contains(illust.user.id.toString())) return true;
    return illust.tags.any((tag) => tags.contains(tag.name));
  }

  bool containsNovel(CommonNovel novel) {
    if (!hasSynced && novel.isMuted) return true;
    if (userIds.contains(novel.user.id.toString())) return true;
    return novel.tags.any((tag) => tags.contains(tag.name));
  }

  bool containsNovelWebView(NovelDetailWebView webViewData) {
    if (!hasSynced && webViewData.authorDetails.isBlocked) return true;
    if (userIds.contains(webViewData.novel.userId)) return true;
    return webViewData.novel.tags.any((tag) => tags.contains(tag));
  }
}

final globalMutedStateProvider =
    StateNotifierProvider<MutedStateNotifier, MutedState>((ref) {
  return MutedStateNotifier();
});

class MutedStateNotifier extends StateNotifier<MutedState> {
  MutedStateNotifier() : super(const MutedState());

  void sync({
    Iterable<String> userIds = const <String>[],
    Iterable<String> tags = const <String>[],
  }) {
    state = MutedState(
      hasSynced: true,
      userIds: Set<String>.from(userIds),
      tags: Set<String>.from(tags),
    );
  }

  void mute({
    Iterable<String> userIds = const <String>[],
    Iterable<String> tags = const <String>[],
  }) {
    state = state.copyWith(
      hasSynced: true,
      userIds: {...state.userIds, ...userIds},
      tags: {...state.tags, ...tags},
    );
  }

  void unmute({
    Iterable<String> userIds = const <String>[],
    Iterable<String> tags = const <String>[],
  }) {
    final nextUserIds = {...state.userIds}..removeAll(userIds);
    final nextTags = {...state.tags}..removeAll(tags);
    state = state.copyWith(
      hasSynced: true,
      userIds: nextUserIds,
      tags: nextTags,
    );
  }
}
