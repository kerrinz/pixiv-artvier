import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/business_component/listview/illust_listview/logic.dart';
import 'package:pixgem/component/image/enhance_network_image.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

class IllustWaterfallItem extends ConsumerStatefulWidget {
  const IllustWaterfallItem({
    Key? key,
    required this.illust,
    required this.collectState,
    required this.onTap,
    this.onTapCollect,
  }) : super(key: key);

  final CommonIllust illust;

  /// 收藏状态
  final CollectState collectState;

  /// 点击卡片的事件
  final VoidCallback onTap;

  /// 点击收藏的事件
  final Function? onTapCollect;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IllustWaterfallItemState();
}

class _IllustWaterfallItemState extends ConsumerState<IllustWaterfallItem> with IllustWaterfallItemLogic {
  @override
  CollectState get collectState => widget.collectState;

  @override
  String get illustId => widget.illust.id.toString();

  ColorScheme get colorScheme => Theme.of(context).colorScheme;

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
  void dispose() {
    // ref.read(collectStateProvider.notifier).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder能获取到父组件的最大支撑宽度
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = (widget.illust.height.toDouble() * constraints.maxWidth) / widget.illust.width;
        // 最高高度（太高了就阉割掉）
        double maxConstraintHeight = constraints.maxWidth * 3;
        return Card(
          elevation: 8.0,
          margin: EdgeInsets.zero,
          shadowColor: colorScheme.secondary.withAlpha(50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.loose,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 图片
                  SizedBox(
                    width: double.infinity,
                    height: height < maxConstraintHeight ? height : maxConstraintHeight,
                    child: EnhanceNetworkImage(
                      image: ExtendedNetworkImageProvider(
                        widget.illust.imageUrls.medium,
                        cache: true,
                        headers: const {"Referer": CONSTANTS.referer},
                      ),
                      fit: BoxFit.cover,
                      width: widget.illust.width.toDouble(),
                      height: widget.illust.height.toDouble(),
                    ),
                  ),
                  // 标题
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 34.0, top: 4.0),
                    child: Text(
                      widget.illust.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  // 作者
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 34.0, bottom: 4.0),
                    child: Text(
                      widget.illust.user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withAlpha(150)),
                    ),
                  ),
                ],
              ),
              // 交互效果层
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.black12.withOpacity(0.15),
                    highlightColor: Colors.black12.withOpacity(0.1),
                    onTap: widget.onTap,
                  ),
                ),
              ),
              // 收藏按钮
              Positioned(
                top: height,
                bottom: 0,
                right: 4,
                child: Center(
                  child: _collectButton(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 收藏按钮
  Widget _collectButton() {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      onTap: handleTapCollect,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Consumer(builder: (_, ref, __) {
          const double size = 28;
          CollectState state = ref.watch(collectStateProvider);
          switch (state) {
            case CollectState.collecting:
              return const Icon(
                Icons.favorite,
                color: Colors.grey,
                size: size,
              );
            case CollectState.uncollecting:
              return Icon(
                Icons.favorite,
                color: Colors.red.shade200,
                size: size,
              );
            case CollectState.collected:
              return const Icon(
                Icons.favorite,
                color: Colors.red,
                size: size,
              );
            case CollectState.notCollect:
              return const Icon(
                Icons.favorite_border_outlined,
                color: Colors.grey,
                size: size,
              );
          }
        }),
      ),
    );
  }
}
