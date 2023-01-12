import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/component/image/enhance_network_image.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:pixgem/global/provider/illust_collect_provider.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artwork/detail/provider/illust_collect_provider.dart';

class IllustWaterfallItem extends ConsumerStatefulWidget {
  final CommonIllust illust;
  final CollectState collectState; // 是否被收藏
  final Function onTap; // 点击卡片的事件
  final Function? onTapCollect; // 点击收藏的事件，会自动刷新收藏按钮的UI

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => IllustWaterfallItemState();

  const IllustWaterfallItem({
    Key? key,
    required this.illust,
    required this.collectState,
    required this.onTap,
    this.onTapCollect,
  }) : super(key: key);
}

class IllustWaterfallItemState extends ConsumerState<IllustWaterfallItem> with _IllustWaterfallItemState {
  @override
  CollectState get _collectState => widget.collectState;

  @override
  String get illustId => widget.illust.id.toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IllustWaterfallItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    ref.invalidate(_collectStateProvider);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<CollectStateChangedArguments?>(globalIllustCollectStateChangedProvider, (previous, next) {
      // var args = ref.read(globalIllustCollectStateChangedProvider);
      if (next != null && next.worksId == illustId) {
        ref.read(_collectStateProvider.notifier).setCollectState(next.state);
      }
    });
    // LayoutBuilder能获取到父组件的最大支撑宽度
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = (widget.illust.height.toDouble() * constraints.maxWidth) / widget.illust.width;
        // 最高高度（太高了就阉割掉）
        double maxConstraintHeight = constraints.maxWidth * 3;
        return Card(
          elevation: 8.0,
          margin: EdgeInsets.zero,
          shadowColor: Theme.of(context).colorScheme.secondary.withAlpha(50),
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
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 34.0, top: 4.0),
                              child: Text(
                                widget.illust.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 34.0, bottom: 4.0),
                              child: Text(
                                widget.illust.user.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.black12.withOpacity(0.15),
                    highlightColor: Colors.black12.withOpacity(0.1),
                    onTap: () => widget.onTap(),
                  ),
                ),
              ),
              // 收藏按钮
              Positioned(
                top: height,
                bottom: 0,
                right: 4,
                child: Center(
                  child: Builder(builder: (BuildContext btnContext) {
                    var i10n = LocalizationIntl.of(context);
                    return InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      onTap: () {
                        // await widget.onTapCollect();
                        var state = ref.read(_collectStateProvider);
                        if (state == CollectState.notCollect) {
                          // 当前未收藏，添加收藏
                          ref
                              .read(_collectStateProvider.notifier)
                              .collect()
                              .then((result) => Fluttertoast.showToast(
                                  msg: result ? i10n.addCollectSucceed : i10n.addCollectFailed,
                                  toastLength: Toast.LENGTH_LONG))
                              .catchError((_) => Fluttertoast.showToast(
                                  msg: "${i10n.addCollectFailed}, (Maybe already collected)",
                                  toastLength: Toast.LENGTH_LONG));
                        }
                        if (state == CollectState.collected) {
                          // 当前已收藏，移除收藏
                          ref
                              .read(_collectStateProvider.notifier)
                              .uncollect()
                              .then((result) => Fluttertoast.showToast(
                                  msg: result ? i10n.removeCollectionSucceed : i10n.removeCollectionFailed,
                                  toastLength: Toast.LENGTH_LONG))
                              .catchError((_) => Fluttertoast.showToast(
                                  msg: "${i10n.removeCollectionFailed}, (Maybe already un-collected)",
                                  toastLength: Toast.LENGTH_LONG));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Builder(builder: (_) {
                          const double size = 28;
                          CollectState state = ref.watch(_collectStateProvider);
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
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

mixin _IllustWaterfallItemState {
  late CollectState _collectState;

  late String illustId;

  late final _collectStateProvider = StateNotifierProvider.autoDispose<CollectNotifier, CollectState>((ref) {
    return CollectNotifier(
      _collectState,
      ref: ref,
      worksId: illustId,
    );
  });
}
