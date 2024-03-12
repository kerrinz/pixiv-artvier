import 'package:artvier/pages/artwork/detail/provider/illust_detail_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/model/advanced_collecting_data.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/advanced_collecting_bottom_sheet.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';
import 'package:artvier/pages/artwork/viewer/model/image_quality_url_model.dart';
import 'package:artvier/pages/artwork/viewer/model/image_viewer_page_arguments.dart';
import 'package:artvier/routes.dart';

mixin ArtworkDetailPageLogic {
  WidgetRef get ref;

  // /// 作品详细信息
  late CommonIllust? artworkDetail;

  /// 作品ID
  late String artworkId;

  /// 插画详情页的收藏状态
  /// 可能有多个插画详情页同时存在于页面栈中，因此使用.family为不同插画id做区分
  late final illustDetailCollectStateProvider = StateNotifierProvider.autoDispose<CollectNotifier, CollectState>((ref) {
    // 监听全局美术作品收藏状态通知器的变化
    ref.listen<CollectStateChangedArguments?>(globalArtworkCollectionStateChangedProvider, (previous, next) {
      if (next != null && next.worksId == artworkId) {
        ref.notifier.setCollectState(next.state);
      }
    });
    if (artworkDetail != null) {
      return CollectNotifier(
        artworkDetail!.isBookmarked ? CollectState.collected : CollectState.notCollect,
        ref: ref,
        worksId: artworkId,
        worksType: WorksType.illust,
      );
    } else {
      // TODO: 有点混乱，虽然能跑（
      var detail = ref.watch(illustDetailProvider(artworkId)).value!.illust;
      return CollectNotifier(
        detail.isBookmarked ? CollectState.collected : CollectState.notCollect,
        ref: ref,
        worksId: artworkId,
        worksType: WorksType.illust,
      );
    }
  });

  /// 点击图片查看大图或原图
  void handleTapImage(CommonIllust detail, int index) {
    List<ImageQualityUrl> urls = [];
    if (detail.metaPages.isEmpty) {
      // 单页作品
      urls = [ImageQualityUrl(normal: detail.imageUrls.large, original: detail.metaSinglePage.originalImageUrl!)];
    } else {
      // 多页作品
      for (var meta in detail.metaPages) {
        urls.add(ImageQualityUrl(normal: meta.imageUrls.large, original: meta.imageUrls.original));
      }
    }
    Navigator.of(ref.context).pushNamed(RouteNames.artworkImagesPreview.name,
        arguments: ImageViewerPageArguments(urlList: urls, index: index));
  }

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
    BottomSheets.showCustomBottomSheet<AdvancedCollectingDataModel>(
      context: ref.context,
      exitOnClickModal: false,
      enableDrag: false,
      child: AdvancedCollectingBottomSheet(
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
