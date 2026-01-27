import 'package:artvier/business_component/listview/comment_listview/comment_listview_provider.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';
import 'package:artvier/l10n/localization_intl.dart';

mixin CommentListViewItemLogic {
  late CollectState collectState;

  late String illustId;

  WidgetRef get ref;

  late final collectStateProvider = StateNotifierProvider.autoDispose<CollectNotifier, CollectState>((ref) {
    return CollectNotifier(collectState, ref: ref, worksId: illustId, worksType: WorksType.illust);
  });

  void handleTapCollect() {
    HapticFeedback.lightImpact();
    var l10n = LocalizationIntl.of(ref.context);
    var state = ref.read(collectStateProvider);
    if (state == CollectState.notCollect) {
      // 当前未收藏，添加收藏
      ref
          .read(collectStateProvider.notifier)
          .collect()
          .then((result) => Fluttertoast.showToast(
              msg: result ? l10n.addCollectSucceed : l10n.addCollectFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(
              msg: "${l10n.addCollectFailed}, (Maybe already collected)", toastLength: Toast.LENGTH_LONG));
    }
    if (state == CollectState.collected) {
      // 当前已收藏，移除收藏
      ref
          .read(collectStateProvider.notifier)
          .uncollect()
          .then((result) => Fluttertoast.showToast(
              msg: result ? l10n.removeCollectionSucceed : l10n.removeCollectionFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(
              msg: "${l10n.removeCollectionFailed}, (Maybe already un-collected)", toastLength: Toast.LENGTH_LONG));
    }
  }
}

mixin CommentRepliesLogic {
  WidgetRef get ref;

  IllustComments? get cachedReplies;
  String get worksId;

  /// 评论回复列表
  /// arg: 评论ID
  late final commentRepliesProvider =
      AsyncNotifierProvider.autoDispose.family<CommentsRepliesNotifier, List<Comments>, int>(() {
    return CommentsRepliesNotifier(initList: cachedReplies?.comments, worksId: worksId);
  });
}
