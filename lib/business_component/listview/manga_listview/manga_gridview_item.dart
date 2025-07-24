import 'package:artvier/business_component/listview/manga_listview/logic.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/util/string_util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/config/enums.dart';

class MangaGridItem extends ConsumerStatefulWidget {
  const MangaGridItem({
    super.key,
    required this.worksId,
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
    this.badges,
    required this.title,
    required this.author,
    required this.totalCollected,
    required this.collectState,
    required this.onTap,
    this.onTapCollect,
  });

  final String worksId;

  final String imageUrl;

  final String title;

  final String author;

  final int totalCollected;

  final int imageWidth;

  final int imageHeight;

  final List<String>? badges;

  /// 收藏状态
  final CollectState collectState;

  /// 点击卡片的事件
  final VoidCallback onTap;

  /// 点击收藏的事件
  final void Function()? onTapCollect;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MangaGridItemState();
}

class _MangaGridItemState extends ConsumerState<MangaGridItem> with MangaGridItemLogic {
  @override
  CollectState get collectState => widget.collectState;

  @override
  String get illustId => widget.worksId;

  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  TextTheme get textTheme => Theme.of(context).textTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MangaGridItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    ref.invalidate(collectStateProvider);
  }

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder能获取到父组件的最大支撑宽度
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = (widget.imageHeight.toDouble() * constraints.maxWidth) / widget.imageWidth;
        // 最高高度（太高了就阉割掉）
        double maxConstraintHeight = constraints.maxWidth * 3;
        return Stack(
          fit: StackFit.loose,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 图片
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: height < maxConstraintHeight ? height : maxConstraintHeight,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(
                            strokeAlign: BorderSide.strokeAlignOutside, color: colorScheme.outline.withAlpha(50)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: EnhanceNetworkImage(
                        fit: BoxFit.cover,
                        width: widget.imageWidth.toDouble(),
                        height: widget.imageHeight.toDouble(),
                        image: ExtendedNetworkImageProvider(
                          HttpHostOverrides().pxImgUrl(widget.imageUrl),
                          cache: true,
                          headers: HttpHostOverrides().pximgHeaders,
                        ),
                      ),
                    ),
                    // 角标
                    if (widget.badges != null && widget.badges!.isNotEmpty)
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Text(
                            widget.badges!.join(','),
                            style: textTheme.labelLarge?.copyWith(color: Colors.white),
                          ),
                        ),
                      )
                  ],
                ),
                // 标题
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                // 作者
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        StringUtil.breakChars(widget.author),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 48, height: 30)
                  ],
                ),
              ],
            ),
            // 交互效果层
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  splashColor: Colors.black12.withValues(alpha: 0.15),
                  highlightColor: Colors.black12.withValues(alpha: 0.1),
                  onTap: () {},
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: widget.onTap,
                  ),
                ),
              ),
            ),
            // 收藏按钮
            Positioned(
              bottom: 0,
              right: 0,
              child: _collectButton(),
            )
          ],
        );
      },
    );
  }

  /// 格式化总收藏量
  String formatTotalCollected(int number) {
    if (number > 1000000) {
      return "${(number / 1000000).floor()}M";
    }
    if (number > 1000) {
      return "${(number / 1000).floor()}K";
    } else {
      return number.toString();
    }
  }

  /// 收藏按钮
  Widget _collectButton() {
    return GestureDetector(
      onLongPress: handleLongPressCollect,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: widget.onTapCollect ?? handleTapCollect,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Consumer(builder: (_, ref, __) {
            const double size = 22;
            CollectState state = ref.watch(collectStateProvider);
            Map<CollectState, Icon> map = {
              CollectState.collecting: Icon(
                Icons.favorite,
                color: Colors.grey.withAlpha(150),
                size: size,
              ),
              CollectState.uncollecting: Icon(
                Icons.favorite,
                color: Colors.red.shade200,
                size: size,
              ),
              CollectState.collected: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: size,
              ),
              CollectState.notCollect: Icon(
                Icons.favorite_border_outlined,
                color: Colors.grey.withAlpha(150),
                size: size,
              )
            };
            return Row(
              children: [
                Text(
                  formatTotalCollected(widget.totalCollected),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: map[state]!,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
