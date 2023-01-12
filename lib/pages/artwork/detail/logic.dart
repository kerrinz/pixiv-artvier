import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/component/bottom_sheet/bottom_sheets.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/global/provider/illust_collect_provider.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artwork/detail/advanced_collect__bottom_sheet.dart';
import 'package:pixgem/pages/artwork/detail/provider/illust_collect_provider.dart';

mixin ArtworkDetailPageLogic {
  // /// 作品详细信息
  late CommonIllust? artworkDetail;

  /// 作品ID
  late String artworkId;

  /// 相关作品列表的懒加载状态
  final relatedLazyloadProvider = StateProvider<LazyloadState>((ref) {
    return LazyloadState.loading;
  });

  /// 插画详情页的收藏状态
  /// 可能有多个插画详情页同时存在于页面栈中，因此使用.family为不同插画id做区分
  late final illustDetailCollectStateProvider =
      StateNotifierProvider.autoDispose<CollectNotifier, CollectState>((ref) {
    var args = ref.watch(globalIllustCollectStateChangedProvider);
    if (args != null && args.worksId == artworkId) {
      /// 全局下发来的通知，更新收藏状态
      return CollectNotifier(
        args.state,
        ref: ref,
        worksId: artworkId,
      );
    }
    return CollectNotifier(
      artworkDetail!.isBookmarked
          ? CollectState.collected
          : CollectState.notCollect,
      ref: ref,
      worksId: artworkId,
    );
  });

  /// 点击收藏按钮的事件
  void handleTapCollect(WidgetRef ref) {
    var i10n = LocalizationIntl.of(ref.context);
    CollectState status = ref.read(illustDetailCollectStateProvider);
    var notifier = ref.read(illustDetailCollectStateProvider.notifier);
    if (status == CollectState.notCollect) {
      // 当前未收藏，添加收藏
      notifier
          .collect()
          .then((result) => Fluttertoast.showToast(
              msg: result ? i10n.addCollectSucceed : i10n.addCollectFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(
              msg: "${i10n.addCollectFailed}, (Maybe already collected)", toastLength: Toast.LENGTH_LONG));
    }
    if (status == CollectState.collected) {
      // 当前已收藏，移除收藏
      notifier
          .uncollect()
          .then((result) => Fluttertoast.showToast(
              msg: result ? i10n.removeCollectionSucceed : i10n.removeCollectionFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(
              msg: "${i10n.removeCollectionFailed}, (Maybe already un-collected)", toastLength: Toast.LENGTH_LONG));
    }
  }

  // 长按收藏按钮的事件
  void handleLongTapCollect(WidgetRef ref) {
    var i10n = LocalizationIntl.of(ref.context);
    CollectState status = ref.read(illustDetailCollectStateProvider);
    if ([CollectState.collecting, CollectState.uncollecting].contains(status)) {
      return;
    }
    // // 高级收藏弹窗
    BottomSheets.showCustomBottomSheet<AdvancedCollectArguments>(
      context: ref.context,
      exitOnClickModal: false,
      enableDrag: false,
      child: AdvancedCollectBottomSheet(
        isCollected: status == CollectState.collected ? true : false,
        worksId: artworkId,
        worksType: WorksType.illust,
      ),
    ).then((value) {
      if (value != null) {
        ref
            .read(illustDetailCollectStateProvider.notifier)
            .collect(args: value)
            .then((result) => Fluttertoast.showToast(
                msg: result ? i10n.addCollectSucceed : i10n.addCollectFailed, toastLength: Toast.LENGTH_LONG))
            .catchError((_) => Fluttertoast.showToast(
                msg: "${i10n.addCollectFailed}, (Maybe already collected)", toastLength: Toast.LENGTH_LONG));
      }
    });
  }
}
