import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/pages/novel/detail/provider/novel_detail_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/model/advanced_collecting_data.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/advanced_collecting_bottom_sheet.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';

mixin NovelDetailPageLogic {
  WidgetRef get ref;

  /// 作品详细信息
  late CommonNovel? novelDetail;

  /// 作品ID
  late String worksId;

  /// 插画详情页的收藏状态
  /// 可能有多个插画详情页同时存在于页面栈中，因此使用.family为不同插画id做区分
  late final novelDetailCollectStateProvider = StateNotifierProvider.autoDispose<CollectNotifier, CollectState>((ref) {
    // 监听全局美术作品收藏状态通知器的变化
    ref.listen<CollectStateChangedArguments?>(globalArtworkCollectionStateChangedProvider, (previous, next) {
      if (next != null && next.worksId == worksId) {
        ref.notifier.setCollectState(next.state);
      }
    });
    if (novelDetail != null) {
      return CollectNotifier(
        novelDetail!.isBookmarked ? CollectState.collected : CollectState.notCollect,
        ref: ref,
        worksId: worksId,
        worksType: WorksType.novel,
      );
    } else {
      // TODO: 有点混乱，虽然能跑（
      var detail = ref.watch(novelDetailProvider(worksId)).value!.novel;
      return CollectNotifier(
        detail.isBookmarked ? CollectState.collected : CollectState.notCollect,
        ref: ref,
        worksId: worksId,
        worksType: WorksType.novel,
      );
    }
  });

  /// 点击收藏按钮的事件
  void handleTapCollect(WidgetRef ref) {
    var i10n = LocalizationIntl.of(ref.context);
    CollectState status = ref.read(novelDetailCollectStateProvider);
    var notifier = ref.read(novelDetailCollectStateProvider.notifier);
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
    CollectState status = ref.read(novelDetailCollectStateProvider);
    if ([CollectState.collecting, CollectState.uncollecting].contains(status)) {
      return;
    }
    // // 高级收藏弹窗
    BottomSheets.showCustomBottomSheet<AdvancedCollectingDataModel>(
      context: ref.context,
      exitOnClickModal: false,
      enableDrag: false,
      child: AdvancedCollectingBottomSheet(
        isCollected: status == CollectState.collected ? true : false,
        worksId: worksId,
        worksType: WorksType.novel,
      ),
    ).then((value) {
      if (value != null) {
        ref
            .read(novelDetailCollectStateProvider.notifier)
            .collect(args: value)
            .then((result) => Fluttertoast.showToast(
                msg: result ? i10n.addCollectSucceed : i10n.addCollectFailed, toastLength: Toast.LENGTH_LONG))
            .catchError((_) => Fluttertoast.showToast(
                msg: "${i10n.addCollectFailed}, (Maybe already collected)", toastLength: Toast.LENGTH_LONG));
      }
    });
  }
}
