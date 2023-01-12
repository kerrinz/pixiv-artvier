import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/component/buttons/blur_button.dart';
import 'package:pixgem/component/drag_view/drag_vertical_container.dart';
import 'package:pixgem/component/image/enhance_network_image.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/component/scroll_view/extend_tab_bar_view.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:pixgem/pages/artwork/detail/logic.dart';
import 'package:pixgem/pages/artwork/detail/widgets/drag_content_pinned.dart';
import 'package:pixgem/pages/artwork/detail/widgets/drag_content_scroll.dart';
import 'package:pixgem/pages/comment/comment_item_widget.dart';
import 'package:pixgem/pages/artwork/detail/provider/illust_comment_provider.dart';
import 'package:pixgem/routes.dart';
import 'package:pixgem/storage/history_store.dart';

class ArtWorksDetailPage extends ConsumerStatefulWidget {
  final IllustDetailPageArguments args; // 数据集

  const ArtWorksDetailPage(Object arguments, {Key? key})
      : args = arguments as IllustDetailPageArguments,
        super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ArtWorksDetailState();
  }
}

class _ArtWorksDetailState extends ConsumerState<ArtWorksDetailPage>
    with TickerProviderStateMixin, ArtworkDetailPageLogic {
  /// 拖拽组件内部滚动内容的控制器
  final ScrollController _scrollController = ScrollController();

  late TabController _tabController;

  late BuildContext _contextDragMin;

  double _scrollOffset = 0;

  double _minimunPosition = 50;

  /// 收藏按钮的高度偏移量
  static const double _floatingButtonOffset = 20;

  /// 拖拽组件最小内容高度
  static const double _minRevealHeight = 180;

  bool _isInit = true;

  final List<double> _size = [0, 0, 0];

  final DragController _dragController = DragController();

  @override
  get artworkDetail => widget.args.detail;
  
  @override
  get artworkId => widget.args.illustId;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    if (widget.args.detail != null) {
      HistoryStore.addIllust(widget.args.detail!); // 保存到历史记录
    }
    _scrollController.addListener(() {
      _scrollOffset = _scrollController.offset;
      // 滚动到顶才允许拖拽
      if (_scrollController.offset > 0) {
        _dragController.setCanStopover(false);
      } else {
        _dragController.setCanStopover(true);
      }
    });
    _dragController.setDragListener((position, status) {
      // 保持滚动位置不变，直到拖拽组件视图最大化
      if (position != _minimunPosition) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollOffset);
        }
      }
    });
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _isInit = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dragController.updatePositions([200]);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top; // 状态栏高度
    double toolBarHeight = Theme.of(context).appBarTheme.toolbarHeight ?? 50;
    // 拖拽组件上拉到顶的极限距离
    _minimunPosition = statusBarHeight + (screenHeight < screenWidth ? 0 : toolBarHeight) - _floatingButtonOffset;
    // 详情数据
    // CommonIllust detail = ref.watch(illustDetailProvider(artworkId))!;
    CommonIllust detail = widget.args.detail!;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          // 内容主体
          Stack(
            children: [
              // 图片浏览区域
              Container(
                padding: const EdgeInsets.only(bottom: _minRevealHeight - _floatingButtonOffset - 20),
                alignment: Alignment.center,
                color: Colors.black,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    width: double.infinity,
                    child: _buildPreviewImages(detail),
                  ),
                ),
              ),
              // appbar/toolbar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  // 状态栏亮度，对应影响到字体颜色（dark为白色字体）
                  leading: AppbarBlurIconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    AppbarBlurIconButton(
                      icon: const Icon(Icons.more_horiz_rounded, color: Colors.white),
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              // 拖拽抽屉区域
              DragVerticalContainer(
                controller: _dragController,
                height: screenHeight -
                    statusBarHeight -
                    (screenHeight < screenWidth ? 0 : toolBarHeight) +
                    _floatingButtonOffset,
                defaultPosition: screenHeight - _minRevealHeight,
                maximumPosition: screenHeight - _minRevealHeight,
                dragStageOffset: 50,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: _floatingButtonOffset),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius:
                            const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(50),
                              offset: const Offset(0, -_floatingButtonOffset),
                              blurRadius: 40,
                              spreadRadius: 5)
                        ],
                      ),
                      child: NotificationListener<PageViewSizeChangedNotification>(
                        onNotification: (notification) => onPageViewHeightChangedNotification(notification),
                        child: NotificationListener<PageViewContentSizeChangedReportingNotification>(
                          onNotification: ((notification) => onPageViewContentSizeChangedNotification(notification)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 拖拽抽屉组件缩到最小时显示的内容
                              Builder(builder: (c1) {
                                _contextDragMin = c1;
                                return DragContentPinned(detail: detail, tabController: _tabController);
                              }),
                              // 概述信息
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                                        child: Row(
                                          children: [
                                            // 点赞数
                                            Expanded(flex: 1, child: Text("id: ${detail.id}")),
                                            // 收藏数
                                            Expanded(
                                              flex: 1,
                                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                Icon(Icons.favorite, size: 18, color: Colors.blueGrey.shade300),
                                                Text(" ${detail.totalBookmarks}",
                                                    style: TextStyle(
                                                        color: Colors.blueGrey.shade400,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w400)),
                                              ]),
                                            ),
                                            // 浏览数
                                            Expanded(
                                              flex: 1,
                                              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                                const Icon(Icons.remove_red_eye, size: 18, color: Colors.grey),
                                                Text(" ${detail.totalView}",
                                                    style: const TextStyle(color: Colors.grey, fontSize: 14)),
                                              ]),
                                            ),
                                          ],
                                        )),
                                    // 简介，字段为comment
                                    Text(
                                      detail.caption,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    // tags
                                    Builder(
                                      builder: (BuildContext context) {
                                        List<Widget> tags = [];
                                        // 遍历displayTags
                                        for (var element in detail.tags) {
                                          // tag标签
                                          tags.add(
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushNamed(RouteNames.searchResult.name, arguments: element.name);
                                              },
                                              child: Text(
                                                "#${element.name} ",
                                                style: TextStyle(
                                                  color: Theme.of(context).colorScheme.primary,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          );
                                          // 标签的翻译文字
                                          tags.add(
                                            Text("${element.translatedName}  "),
                                          );
                                        }
                                        return Wrap(
                                          children: tags,
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                              // 评论（预览部分）
                              _commentsPreview(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // 悬浮收藏按钮
                    Positioned(
                      right: 20,
                      child: _collectButton(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 顶部阴影渐变区域
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: statusBarHeight,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0x80000000),
                  Color(0x40000000),
                  Color(0x00000000),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewImages(detail) {
    List<MetaPages> metaPages = [];
    if (detail.metaPages.isEmpty) {
      metaPages.add(MetaPages(detail.imageUrls));
    } else {
      metaPages.addAll(detail.metaPages);
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteNames.artworkImagesPreview.name, arguments: detail);
      },
      child: Column(
        children: [
          for (MetaPages metaPage in metaPages)
            Builder(builder: (context) {
              Key? imgKey = Key(DateTime.now().millisecondsSinceEpoch.toString());
              return EnhanceNetworkImage(
                key: imgKey,
                image: ExtendedNetworkImageProvider(
                  metaPage.imageUrls.large,
                  headers: const {"referer": CONSTANTS.referer},
                  cache: true,
                ),
                // key: _imgKey,
                errorWidget: (context, url, error) {
                  return LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Container(
                        alignment: Alignment.center,
                        width: constraints.maxWidth,
                        height: detail.height / detail.width * constraints.maxWidth,
                        child: ElevatedButton(
                          onPressed: () {
                            (context as Element).markNeedsBuild();
                          },
                          child: const Text("加载失败，点击重试"),
                        ),
                      );
                    },
                  );
                },
                // 加载时显示loading图标
                loadingWidget: (BuildContext context, String url, ImageChunkEvent process) {
                  return LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Container(
                        alignment: Alignment.center,
                        width: constraints.maxWidth,
                        height: detail.height / detail.width * constraints.maxWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              // strokeWidth: 4.0,
                              value: process.progress,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text("${((process.progress ?? 0) * 100).toStringAsFixed(0)}%"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            }),
        ],
      ),
    );
  }

  /// 收藏按钮
  Widget _collectButton() {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onLongPress: (() => handleLongTapCollect(ref)),
      child: InkWell(
        onTap: () => handleTapCollect(ref),
        child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              gradient: LinearGradient(colors: [
                colorScheme.surface,
                colorScheme.surface,
                colorScheme.surface,
                colorScheme.surface.withAlpha(0),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Consumer(builder: ((context, ref, child) {
              CollectState status = ref.watch(illustDetailCollectStateProvider);
              switch (status) {
                case CollectState.collecting:
                  return const Icon(
                    Icons.favorite,
                    color: Colors.grey,
                    size: 28,
                  );
                case CollectState.uncollecting:
                  return Icon(
                    Icons.favorite,
                    color: Colors.red.shade200,
                    size: 28,
                  );
                case CollectState.collected:
                  return const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 28,
                  );
                case CollectState.notCollect:
                  return const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.grey,
                    size: 28,
                  );
              }
            }))),
      ),
    );
  }

  /// 预览版评论区
  Widget _commentsPreview() {
    return Consumer(builder: ((context, ref, child) {
      var provider = ref.watch(commentsPreviewProvider(artworkId));
      return provider.when(
        data: ((data) {
          int len = data.length < 3 ? data.length : 3;
          List<Widget> widgets = [];
          for (int i = 0; i < len; i++) {
            widgets.add(CommentWidget(comment: data[i]));
          }
          return Column(children: widgets);
        }),
        error: ((error, stackTrace) => RequestLoadingFailed(onRetry: () {})),
        loading: (() => const RequestLoading()),
      );
    }));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// PageView高度变化的通知
  bool onPageViewHeightChangedNotification(PageViewSizeChangedNotification notification) {
    if (_isInit) {
      return false;
    }
    if (_size[_tabController.index] == 0) return false;
    double mediaHeight = MediaQuery.of(context).size.height;
    bool isHorizontal = mediaHeight < MediaQuery.of(context).size.width;
    double position = isHorizontal
        ? MediaQuery.of(context).padding.top - _floatingButtonOffset
        : (mediaHeight - _floatingButtonOffset - _contextDragMin.size!.height - _size[_tabController.index]);
    if (position < _minimunPosition) position = _minimunPosition;
    _dragController.updatePositions([position]);
    _dragController.dragTo(position);
    return false;
  }

  bool onPageViewContentSizeChangedNotification(PageViewContentSizeChangedReportingNotification notification) {
    _size[notification.index] = notification.size?.height ?? 0;
    double mediaHeight = MediaQuery.of(context).size.height;
    bool isHorizontal = mediaHeight < MediaQuery.of(context).size.width;
    double position = isHorizontal
        ? MediaQuery.of(context).padding.top - _floatingButtonOffset
        : (mediaHeight - _floatingButtonOffset - _contextDragMin.size!.height - _size[notification.index]);
    if (position < _minimunPosition) position = _minimunPosition;
    _dragController.updatePositions([position]);
    if (_isInit) {
      _isInit = false;
    } else {
      _dragController.dragTo(position);
    }
    return false;
  }
}
