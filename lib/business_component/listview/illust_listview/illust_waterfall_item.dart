import 'package:artvier/global/model/works_badge_argument/works_badge_argument.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/util/string_util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/illust_listview/logic.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/config/enums.dart';

class IllustWaterfallItem extends ConsumerStatefulWidget {
  const IllustWaterfallItem({
    super.key,
    required this.worksId,
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.title,
    required this.author,
    required this.totalCollected,
    required this.collectState,
    required this.onTap,
    this.leftTopBadges,
    this.rightTopBadges,
    this.pageCount = 1,
    this.type = "illust",
    this.xAgeRestrict = 0,
    this.isAI = false,
    this.onTapCollect,
    this.onLongPressCollect,
  });

  final String worksId;

  final String imageUrl;

  final String title;

  final String author;

  final int totalCollected;

  final int imageWidth;

  final int imageHeight;

  final List<WorksBadgeArgument>? leftTopBadges;

  final List<WorksBadgeArgument>? rightTopBadges;

  final int pageCount;

  final String type;

  /// 年龄分级，0: 全年龄，1: R18
  final int xAgeRestrict;

  /// AI 作品
  final bool isAI;

  /// 收藏状态
  final CollectState collectState;

  /// 点击卡片的事件
  final VoidCallback onTap;

  /// 点击收藏的事件
  final void Function()? onTapCollect;

  /// 长按收藏的事件
  final void Function()? onLongPressCollect;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IllustWaterfallItemState();
}

class _IllustWaterfallItemState extends ConsumerState<IllustWaterfallItem> with IllustWaterfallItemLogic {
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
  void didUpdateWidget(covariant IllustWaterfallItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    ref.invalidate(collectStateProvider);
  }

  @override
  Widget build(BuildContext context) {
    final rightTopBadges = [
      if (widget.isAI) const WorksBadgeArgument(text: "AI"),
      if (widget.pageCount > 1) WorksBadgeArgument(text: widget.pageCount.toString()),
      if (widget.type == "ugoira") const WorksBadgeArgument(text: "Ugoira"),
      if (widget.rightTopBadges != null) ...widget.rightTopBadges!
    ];
    final leftTopBadges = [
      if (widget.xAgeRestrict == 1)
        const WorksBadgeArgument(text: "R18", backgroundColor: Color(0xFFFF3855), textColor: Colors.white),
      if (widget.leftTopBadges != null) ...widget.leftTopBadges!
    ];
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
                    if (leftTopBadges.isNotEmpty)
                      Positioned(
                        left: 6,
                        top: 6,
                        child: _buildBadge(leftTopBadges),
                      ),
                    if (rightTopBadges.isNotEmpty)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: _buildBadge(rightTopBadges),
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
                child: GestureDetector(
                  // splashFactory: InkSparkle.splashFactory,
                  // splashColor: Colors.black12.withOpacity(0.15),
                  // highlightColor: Colors.black12.withOpacity(0.1),
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

  Widget _buildBadge(List<WorksBadgeArgument> badges) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final badge in badges)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: badge.backgroundColor ?? Colors.black26,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              badge.text,
              style: textTheme.labelMedium?.copyWith(
                color: badge.textColor ?? Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.1,
              ),
            ),
          ),
      ],
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
      onLongPress: widget.onLongPressCollect ?? handleLongPressCollect,
      child: InkWell(
        splashFactory: InkSparkle.splashFactory,
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
