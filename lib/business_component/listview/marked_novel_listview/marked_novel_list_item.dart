import 'package:artvier/model_response/novels/marker_novel.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/model_response/novels/common_novel.dart';

/// 小说瀑布流对应的列表项
class MarkedNovelWaterfallItem extends ConsumerStatefulWidget {
  const MarkedNovelWaterfallItem({
    super.key,
    required this.marked,
    required this.collectState,
    required this.onTap,
  });

  final MarkedNovel marked;

  /// 收藏状态
  final CollectState collectState;

  /// 点击卡片的事件
  final VoidCallback onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MarkedNovelWaterfallItemState();
}

class _MarkedNovelWaterfallItemState extends ConsumerState<MarkedNovelWaterfallItem>
    with _MarkedNovelListViewItemLogic {
  @override
  CollectState get collectState => widget.collectState;

  @override
  String get novelId => widget.marked.novel.id.toString();

  @override
  Widget build(BuildContext context) {
    final l10n = LocalizationIntl.of(context);
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
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Colors.transparent),
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
                          if (widget.marked.novel.series.title != null)
                            // 小说系列的信息栏
                            _seriesInfo(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 小说标题
                              Text(
                                widget.marked.novel.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              // 作者
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  children: [
                                    const Icon(Icons.person_2_rounded, size: 16),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 2.0),
                                      child: Text(
                                        widget.marked.novel.user.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // 小说标签
                          _tagItems(),
                          Text("${l10n.markers}: P${widget.marked.novelMarker.page}"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
          HttpHostOverrides().pxImgUrl(widget.marked.novel.imageUrls.medium),
          headers: HttpHostOverrides().pximgHeaders,
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
        Text(
          LocalizationIntl.of(context).series,
          style: const TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.marked.novel.series.title ?? "",
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
    StringBuffer sb = StringBuffer("${widget.marked.novel.textLength.toString()}字 ");
    for (Tags tag in widget.marked.novel.tags) {
      sb.write("#");
      sb.write(tag.translatedName ?? tag.name);
      sb.write("  ");
    }
    return Wrap(
      children: [
        RichText(
          text: TextSpan(
            text: widget.marked.novel.xRestrict == 1 ? "R18  " : '',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFFFF3855),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                ),
            children: [
              TextSpan(
                text: sb.toString(),
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withAlpha(200)),
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          maxLines: 3,
        ),
      ],
    );
  }
}

mixin _MarkedNovelListViewItemLogic {
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
