import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixgem/common_provider/bookmark_status_provider_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/common_provider/works_provider.dart';
import 'package:pixgem/component/bottom_sheet/bottom_sheets.dart';
import 'package:pixgem/component/buttons/blur_button.dart';
import 'package:pixgem/component/drag_view/drag_vertical_container.dart';
import 'package:pixgem/component/image/enhance_network_image.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/component/scroll_view/extend_tab_bar_view.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artwork/detail/advanced_collect__bottom_sheet.dart';
import 'package:pixgem/pages/artwork/detail/arguments.dart';
import 'package:pixgem/pages/artwork/detail/vm.dart';
import 'package:pixgem/pages/artwork/detail/widgets/drag_content_pinned.dart';
import 'package:pixgem/pages/artwork/detail/widgets/drag_content_scroll.dart';
import 'package:pixgem/routes.dart';
import 'package:pixgem/store/history_store.dart';
import 'package:provider/provider.dart';

class ArtWorksDetailPage extends StatefulWidget {
  late final ArkworkDetailPageArguments model; // 数据集

  ArtWorksDetailPage(Object arguments, {Key? key}) : super(key: key) {
    model = arguments as ArkworkDetailPageArguments;
  }

  @override
  State<StatefulWidget> createState() {
    return _ArtWorksDetailState();
  }
}

class _ArtWorksDetailState extends State<ArtWorksDetailPage> with TickerProviderStateMixin {
  /// 拖拽组件内部滚动内容的控制器
  final ScrollController _scrollController = ScrollController();

  late TabController _tabController;

  late BuildContext _contextDragMin;

  double _scrollOffset = 0;

  /// 管理<评论+相关作品>整体的加载
  late final ArtWorkDetailPageVM _vm;

  double _minimunPosition = 50;

  /// 收藏按钮的高度偏移量
  static const double _floatingButtonOffset = 20;

  /// 拖拽组件最小内容高度
  static const double _minRevealHeight = 180;

  bool _isInit = true;

  final List<double> _size = [0, 0, 0];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _vm = ArtWorkDetailPageVM(
      widget.model.artworkId,
      widget.model.detail,
      widget.model.detail!.isBookmarked ? BookmarkStatus.bookmarked : BookmarkStatus.notBookmark,
      widget.model.callback,
    );
    if (widget.model.detail != null) {
      HistoryStore.addIllust(widget.model.detail!); // 保存到历史记录
    }
    _scrollController.addListener(() {
      _scrollOffset = _scrollController.offset;
      // 滚动到顶才允许拖拽
      if (_scrollController.offset > 0) {
        _vm.dragController.setCanStopover(false);
      } else {
        _vm.dragController.setCanStopover(true);
      }
    });
    _vm.dragController.setDragListener((position, status) {
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
      _vm.dragController.updatePositions([200]);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_vm.pageLoadingStatus == LoadingStatus.loading) {
      return const RequestLoading();
    } else if (_vm.pageLoadingStatus == LoadingStatus.failed) {
      return RequestLoadingFailed(onRetry: () => {_vm.requestArtworkDetail()});
    }
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top; // 状态栏高度
    double toolBarHeight = Theme.of(context).appBarTheme.toolbarHeight ?? 50;
    // 拖拽组件上拉到顶的极限距离
    _minimunPosition = statusBarHeight + (screenHeight < screenWidth ? 0 : toolBarHeight) - _floatingButtonOffset;
    // 详情数据
    CommonIllust detail = _vm.artworkDetail!;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          // 内容主体
          ChangeNotifierProvider<ArtWorkDetailPageVM>.value(
            value: _vm,
            child: Stack(
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
                        onPressed: () {
                          // TODO: Bottom sheet
                        },
                      )
                    ],
                  ),
                ),
                // 拖拽抽屉区域
                DragVerticalContainer(
                  controller: _vm.dragController,
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
                              spreadRadius: 5
                            )
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
                                // 分页内容
                                Expanded(
                                  child: PrimaryScrollController(
                                    controller: _scrollController,
                                    child: DragContentScroll(
                                      detail: detail,
                                      tabController: _tabController,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 悬浮收藏按钮
                      Positioned(
                        right: 20,
                        child: _buildCollectButton(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

  Widget _buildCollectButton() {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onLongPress: (() {
        if ([BookmarkStatus.bookmarking, BookmarkStatus.unBookmarking].contains(_vm.collectStatus)) {
          return;
        }
        // 高级收藏弹窗
        BottomSheets.showCustomBottomSheet<AdvancedCollectArguments>(
          context: context,
          exitOnClickModal: false,
          enableDrag: false,
          child: AdvancedCollectBottomSheet(
            isCollected: BookmarkStatus.bookmarked == _vm.collectStatus ? true : false,
            worksId: _vm.artworkId,
            worksType: WorksType.illust,
          ),
        ).then((value) {
          if (value != null) {
            _vm.collectByAdvanced(context, value);
          }
        });
      }),
      child: InkWell(
        onTap: () {
          if (BookmarkStatus.bookmarked == _vm.collectStatus) {
            _vm.unCollect(context);
          } else if (BookmarkStatus.notBookmark == _vm.collectStatus) {
            _vm.collect(context);
          }
        },
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
          child: Selector<ArtWorkDetailPageVM, BookmarkStatus>(
            selector: ((context, vm) => vm.collectStatus),
            builder: ((context, value, child) {
              switch (value) {
                case BookmarkStatus.bookmarking:
                  return const Icon(
                    Icons.favorite,
                    color: Colors.grey,
                    size: 28,
                  );
                case BookmarkStatus.unBookmarking:
                  return Icon(
                    Icons.favorite,
                    color: Colors.red.shade200,
                    size: 28,
                  );
                case BookmarkStatus.bookmarked:
                  return const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 28,
                  );
                case BookmarkStatus.notBookmark:
                  return const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.grey,
                    size: 28,
                  );
              }
            }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // if (!_detailCancelToken.isCancelled) _detailCancelToken.cancel();
    // if (!_commentCancelToken.isCancelled) _detailCancelToken.cancel();
    _vm.dispose();
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
    _vm.dragController.updatePositions([position]);
    _vm.dragController.dragTo(position);
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
    _vm.dragController.updatePositions([position]);
    if (_isInit) {
      _isInit = false;
    } else {
      _vm.dragController.dragTo(position);
    }
    return false;
  }
}
