import 'package:artvier/global/logger.dart';
import 'package:artvier/global/model/marker_state_changed_arguments/marker_state_changed_arguments.dart';
import 'package:artvier/global/provider/novel_marker_provider.dart';
import 'package:artvier/model_response/novels/marker_novel.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/config/enums.dart';
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
  NovelMarker? get novelMarker => widget.marked.novelMarker;

  @override
  String get novelId => widget.marked.novel.id.toString();

  @override
  Widget build(BuildContext context) {
    LocalizationIntl.of(context);
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (widget.marked.novel.series.title != null)
                                          // 小说系列的信息栏
                                          _seriesInfo(),
                                        // 小说标题
                                        Text(
                                          widget.marked.novel.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Builder(builder: (context) {
                                    IconData icon = Icons.bookmark;
                                    Color? color = Colors.red;
                                    switch (widget.marked.markerState) {
                                      case null:
                                        if (widget.marked.novelMarker?.page != null) {
                                          icon = Icons.bookmark;
                                          color = Colors.red;
                                        } else {
                                          icon = Icons.bookmark_add_outlined;
                                          color = null;
                                        }
                                        break;
                                      case MarkerState.addingMarker:
                                        icon = Icons.bookmark;
                                        color = Colors.grey;
                                        break;
                                      case MarkerState.removingMarker:
                                        icon = Icons.bookmark;
                                        color = Colors.red.withOpacity(0.5);
                                        break;
                                      case MarkerState.marked:
                                        icon = Icons.bookmark;
                                        color = Colors.red;
                                        break;
                                      case MarkerState.unmarked:
                                        icon = Icons.bookmark_add_outlined;
                                        color = null;
                                        break;
                                      default:
                                    }
                                    return IconButton(
                                      onPressed: handleTapMarker,
                                      icon: Icon(icon),
                                      color: color,
                                    );
                                  }),
                                ],
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
  late NovelMarker? novelMarker;

  late String novelId;

  WidgetRef get ref;

  late final markerStateProvider =
      StateNotifierProvider.autoDispose<MarkerStateNotifier, MarkerStateChangedArguments>((ref) {
    ref.listen<MarkerStateChangedArguments?>(globalNovelMarkerStateChangedProvider, (previous, next) {
      if (next != null && next.worksId == novelId) {
        ref.notifier.setMarkerState(next);
      }
    });

    return MarkerStateNotifier(
        MarkerStateChangedArguments(
            worksId: novelId,
            page: novelMarker?.page,
            state: novelMarker?.page != null ? MarkerState.marked : MarkerState.unmarked),
        ref: ref,
        novelId: novelId);
  });

  void handleTapMarker() {
    HapticFeedback.lightImpact();
    if (novelMarker?.page == null) {
      logger.e("novelMarker?.page is null. id: $novelId");
      return;
    }
    var l10n = LocalizationIntl.of(ref.context);
    var state = ref.read(markerStateProvider);
    // TODO: 取消书签后再添加书签有 bug
    if (state.state == MarkerState.unmarked) {
      ref
          .read(markerStateProvider.notifier)
          .marker(page: novelMarker!.page)
          .then((result) => Fluttertoast.showToast(
              msg: result ? l10n.addMarkerSucceed : l10n.addMarkerFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(msg: l10n.addMarkerFailed, toastLength: Toast.LENGTH_LONG));
    } else if (state.state == MarkerState.marked) {
      ref
          .read(markerStateProvider.notifier)
          .unmarker()
          .then((result) => Fluttertoast.showToast(
              msg: result ? l10n.removeMarkerSucceed : l10n.removeMarkerFailed, toastLength: Toast.LENGTH_LONG))
          .catchError((_) => Fluttertoast.showToast(msg: l10n.removeMarkerFailed, toastLength: Toast.LENGTH_LONG));
    }
  }
}
