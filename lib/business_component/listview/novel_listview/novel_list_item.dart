import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/model_response/novels/common_novel.dart';

/// 小说瀑布流对应的列表项
class NovelWaterfallItem extends ConsumerStatefulWidget {
  const NovelWaterfallItem({
    Key? key,
    required this.novel,
    required this.collectState,
    required this.onTap,
  }) : super(key: key);

  final CommonNovel novel;

  /// 收藏状态
  final CollectState collectState;

  /// 点击卡片的事件
  final VoidCallback onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NovelWaterfallItemState();
}

class _NovelWaterfallItemState extends ConsumerState<NovelWaterfallItem> with _NovelListViewItemLogic {
  @override
  CollectState get collectState => widget.collectState;

  @override
  String get novelId => widget.novel.id.toString();

  @override
  Widget build(BuildContext context) {
    // 获取到父组件的最大支撑宽度
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxWidth * 0.36;
        return Container(
          width: constraints.maxWidth,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 封面
                _novelCover(constraints.maxWidth * 0.26, height),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.novel.series.title != null)
                          // 小说系列的信息栏
                          _seriesInfo(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 小说标题
                            Text(
                              widget.novel.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            // 作者
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  const Icon(Icons.person_outline_rounded, size: 16),
                                  Text(
                                    widget.novel.user.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // 小说标签
                        _tagItems(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _novelCover(width, height) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      child: EnhanceNetworkImage(
        image: ExtendedNetworkImageProvider(
          widget.novel.imageUrls.medium,
          headers: const {"Referer": CONSTANTS.referer},
          cache: true,
        ),
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }

  /// 小说系列的信息栏
  Widget _seriesInfo() {
    return Row(
      children: [
        Badge(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          color: Colors.amber,
          child: Text(
            LocalizationIntl.of(context).series,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.novel.series.title ?? "",
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  /// 小说标签
  Widget _tagItems() {
    StringBuffer sb = StringBuffer("${widget.novel.textLength.toString()}字 ");
    for (Tags tag in widget.novel.tags) {
      sb.write("#");
      sb.write(tag.name);
      sb.write(" ");
    }
    return Text(
      sb.toString(),
      style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withAlpha(200)),
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      maxLines: 2,
    );
  }
}

mixin _NovelListViewItemLogic {
  late CollectState collectState;

  late String novelId;

  WidgetRef get ref;

  late final collectStateProvider = StateNotifierProvider.autoDispose<CollectNotifier, CollectState>((ref) {
    // 监听全局小说收藏状态通知器的变化
    ref.listen<CollectStateChangedArguments?>(globalArtworkCollectionStateChangedProvider, (previous, next) {
      if (next != null && next.worksId == novelId) {
        ref.notifier.setCollectState(next.state);
      }
    });
    
    return CollectNotifier(collectState, ref: ref, worksId: novelId, worksType: WorksType.novel);
  });

  void handleTapCollect() {
    var i10n = LocalizationIntl.of(ref.context);
    var state = ref.read(collectStateProvider);
    if (state == CollectState.notCollect) {
      // 当前未收藏，添加收藏
      ref
          .read(collectStateProvider.notifier)
          .collect()
          .then((result) => Fluttertoast.showToast(
              msg: result ? i10n.addCollectSucceed : i10n.addCollectFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(
              msg: "${i10n.addCollectFailed}, (Maybe already collected)", toastLength: Toast.LENGTH_LONG));
    }
    if (state == CollectState.collected) {
      // 当前已收藏，移除收藏
      ref
          .read(collectStateProvider.notifier)
          .uncollect()
          .then((result) => Fluttertoast.showToast(
              msg: result ? i10n.removeCollectionSucceed : i10n.removeCollectionFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(
              msg: "${i10n.removeCollectionFailed}, (Maybe already un-collected)", toastLength: Toast.LENGTH_LONG));
    }
  }
}
