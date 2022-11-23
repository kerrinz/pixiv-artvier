import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/common_provider/bookmark_status_provider_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/common_provider/works_provider.dart';
import 'package:pixgem/component/base_provider_widget.dart';
import 'package:pixgem/component/bottom_sheet/bottom_sheets.dart';
import 'package:pixgem/component/bottom_sheet/slide_bar.dart';
import 'package:pixgem/component/buttons/follow_button.dart';
import 'package:pixgem/component/drag_view/drag_vertical_container.dart';
import 'package:pixgem/component/image/enhance_network_image.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/illusts/illust_comments.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/pages/artwork/detail/advanced_collect__bottom_sheet.dart';
import 'package:pixgem/pages/artwork/detail/artwork_detail_arguments.dart';
import 'package:pixgem/pages/comment/comment_item_widget.dart';
import 'package:pixgem/api_app/api_illusts.dart';
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

class _ArtWorksDetailState extends State<ArtWorksDetailPage> {
  DragController dragController = DragController();

  /// 拖拽组件内部滚动内容的控制器
  ScrollController scrollController = ScrollController();

  double scrollOffset = 0;

  // Drag拖拽组件阶段1增量的上下文
  late BuildContext _increase1Context;

  final BookmarkStatusProvider _bookmarkProvider = BookmarkStatusProvider(bookmarkStatus: BookmarkStatus.notBookmark);

  /// 管理<评论+相关作品>整体的加载
  final LoadingRequestProvider _loadingProvider = LoadingRequestProvider();

  /// （仅无预载入数据即全屏加载时生效）管理整个页面的总体加载状态
  late LoadingStatus _fullLoadingStatus;

  CancelToken _detailCancelToken = CancelToken();

  CancelToken _commentCancelToken = CancelToken();

  // Key? imgKeys = Key(DateTime.now().millisecondsSinceEpoch.toString());

  /// 存放作品详情（在[widget.model.detail]为空时才会用到）
  CommonIllust? _artworkDetail;

  /// 评论列表（仅显示部分）o
  final List<Comments> _commentList = [];

  /// 作品id
  String get _currentArtworkId => widget.model.artworkId;

  double minimunPosition = 50;

  /// 收藏按钮的高度偏移量
  static const double floatingButtonOffset = 20;

  /// 拖拽组件最小内容高度
  static const double minRevealHeight = 160;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    if (widget.model.detail != null) {
      _fullLoadingStatus = LoadingStatus.success;
      _bookmarkProvider.setBookmarkStatus(
        widget.model.detail!.isBookmarked ? BookmarkStatus.bookmarked : BookmarkStatus.notBookmark,
      );
      HistoryStore.addIllust(widget.model.detail!); // 保存到历史记录
    } else {
      _fullLoadingStatus = LoadingStatus.loading;
      requestArtworkDetail(widget.model.artworkId);
    }
    requestComment(_currentArtworkId);
    scrollController.addListener(() {
      scrollOffset = scrollController.offset;
      // 滚动到顶才允许拖拽
      if (scrollController.offset > 0) {
        dragController.setCanStopover(false);
      } else {
        dragController.setCanStopover(true);
      }
    });
    dragController.setDragListener((position, status) {
      // 保持滚动位置不变，直到拖拽组件视图最大化
      if (position != minimunPosition) {
        scrollController.jumpTo(scrollOffset);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool isHorizontal = MediaQuery.of(context).size.height < MediaQuery.of(context).size.width; // 是否横屏模式
      // 更新可供拖拽组件停留的位置
      double step1Position =
          MediaQuery.of(context).size.height - minRevealHeight - (_increase1Context.size?.height ?? 0);
      dragController.updatePositions(
        [if (!isHorizontal && step1Position > minimunPosition) step1Position],
      );
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_fullLoadingStatus == LoadingStatus.loading) {
      return const RequestLoading();
    } else if (_fullLoadingStatus == LoadingStatus.failed) {
      return RequestLoadingFailed(onRetry: () => {requestArtworkDetail(_currentArtworkId)});
    }
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top; // 状态栏高度
    double toolBarHeight = Theme.of(context).appBarTheme.toolbarHeight ?? 50;
    // 拖拽组件上拉到顶的极限距离
    minimunPosition = statusBarHeight + (screenHeight < screenWidth ? 0 : toolBarHeight) - floatingButtonOffset;
    // 详情数据
    CommonIllust detail = widget.model.detail ?? _artworkDetail!;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          // 内容主体
          Builder(
            builder: (BuildContext context) {
              return Stack(
                children: [
                  // 图片浏览区域
                  Container(
                    padding: const EdgeInsets.only(bottom: minRevealHeight - floatingButtonOffset - 20),
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      physics: const BouncingScrollPhysics(),
                      child: SizedBox(
                        width: double.infinity,
                        child: _buildPreviewImage(context, detail),
                      ),
                    ),
                  ),
                  // appbar/toolbar
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AppBar(
                      title: Text(
                        detail.title,
                        style: const TextStyle(fontSize: 18),
                      ),
                      titleTextStyle: const TextStyle(color: Colors.white),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      // 状态栏亮度，对应影响到字体颜色（dark为白色字体）
                      leading: Builder(builder: (context) {
                        return IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      }),
                    ),
                  ),
                  // 拖拽抽屉区域
                  DragVerticalContainer(
                    controller: dragController,
                    height: screenHeight -
                        statusBarHeight -
                        (screenHeight < screenWidth ? 0 : toolBarHeight) +
                        floatingButtonOffset,
                    defaultPosition: screenHeight - minRevealHeight,
                    minimunPosition: minimunPosition,
                    maximumPosition: screenHeight - minRevealHeight,
                    dragStageOffset: 50,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: floatingButtonOffset),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(50),
                                offset: const Offset(0, -floatingButtonOffset),
                                blurRadius: 40,
                                spreadRadius: 5,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 1),
                                child: BottomSheetSlideBar(width: 48, height: 3),
                              ),
                              // 拖拽抽屉最小展示内容
                              ..._buildDragContentMinView(context, colorScheme, detail),
                              Expanded(
                                child: PrimaryScrollController(
                                  controller: scrollController,
                                  child: CustomScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    slivers: [
                                      // 拖拽抽屉次要的内容
                                      SliverToBoxAdapter(child: Builder(builder: (context1) {
                                        _increase1Context = context1;
                                        return _buildDragContentSecondView(context, detail);
                                      })),
                                      // 拖拽抽屉最大化时的其他内容
                                      ..._buildDragContentOtherView(context, detail),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 悬浮收藏按钮
                        Positioned(
                          right: 20,
                          child: ProviderWidget<BookmarkStatusProvider>(
                            model: _bookmarkProvider,
                            builder: ((context, value, child) {
                              return GestureDetector(
                                onLongPress: (() async {
                                  switch (_bookmarkProvider.bookmarkStatus) {
                                    case BookmarkStatus.bookmarking:
                                    case BookmarkStatus.unBookmarking:
                                      return;
                                    default:
                                  }
                                  AdvancedCollectArguments? arguments =
                                      await BottomSheets.showCustomBottomSheet<AdvancedCollectArguments>(
                                    context: context,
                                    exitOnClickModal: false,
                                    enableDrag: false,
                                    child: AdvancedCollectBottomSheet(
                                      isCollected:
                                          _bookmarkProvider.bookmarkStatus == BookmarkStatus.bookmarked ? true : false,
                                      worksId: _currentArtworkId,
                                      worksType: WorksType.illust,
                                    ),
                                  );
                                  if (arguments == null) return;
                                  submitAdvancedBookmark(arguments);
                                }),
                                child: InkWell(
                                  onTap: () {
                                    if ([BookmarkStatus.bookmarked, BookmarkStatus.notBookmark]
                                        .contains(_bookmarkProvider.bookmarkStatus)) {
                                      requestBookmark(_bookmarkProvider.bookmarkStatus);
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
                                        borderRadius: const BorderRadius.all(Radius.circular(50))),
                                    child: Consumer(
                                      builder: (BuildContext context, BookmarkStatusProvider provider, Widget? child) {
                                        switch (provider.bookmarkStatus) {
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
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
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

  // 构建预览大图
  Widget _buildPreviewImage(BuildContext context, CommonIllust detail) {
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
            EnhanceNetworkImage(
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
                          setState(() {
                            // _imgKey = Key(DateTime.now().millisecondsSinceEpoch.toString());
                          });
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
            ),
        ],
      ),
    );
  }

  // 拖拽抽屉最小展示内容
  List<Widget> _buildDragContentMinView(BuildContext context, ColorScheme colorScheme, CommonIllust detail) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
        child: FittedBox(child: Text(detail.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 60,
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.userDetail.name,
                    arguments:
                        PreloadUserLeastInfo(detail.user.id, detail.user.name, detail.user.profileImageUrls.medium));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 作者头像
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ClipOval(
                        child: EnhanceNetworkImage(
                          image: ExtendedNetworkImageProvider(
                            detail.user.profileImageUrls.medium,
                            headers: const {"Referer": CONSTANTS.referer},
                          ),
                          fit: BoxFit.cover,
                          width: 46,
                          height: 46,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 作者昵称
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              detail.user.name,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colorScheme.primary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // 发布时间
                          Text(
                            formatDate(
                                DateTime.parse(detail.createDate), [yyyy, '-', mm, '-', dd, ' ', HH, ':', mm, ':', ss]),
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // 关注或已关注的按钮
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                      child: FollowButton(
                        isFollowed: detail.user.isFollowed!,
                        userId: detail.user.id.toString(),
                        followedStyle: FollowButtonStyle(
                          color: colorScheme.primaryContainer,
                          textStyle: TextStyle(color: colorScheme.primary, fontSize: 14.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ];
  }

  // 拖拽抽屉次要的内容
  Widget _buildDragContentSecondView(BuildContext context, CommonIllust detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
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
                          style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 15, fontWeight: FontWeight.w400)),
                    ]),
                  ),
                  // 浏览数
                  Expanded(
                    flex: 1,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      const Icon(Icons.remove_red_eye, size: 18, color: Colors.grey),
                      Text(" ${detail.totalView}", style: const TextStyle(color: Colors.grey, fontSize: 14)),
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
                      Navigator.of(context).pushNamed(RouteNames.searchResult.name, arguments: element.name);
                    },
                    child: Text("#${element.name} ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600, fontSize: 15)),
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
    );
  }

  // 拖拽抽屉的其他内容（上拉到最大化时才会显示的内容）
  List<Widget> _buildDragContentOtherView(BuildContext context, CommonIllust detail) {
    return [
      SliverToBoxAdapter(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 200),
          child: ProviderWidget(
            model: _loadingProvider,
            builder: ((context, LoadingRequestProvider provider, child) {
              switch (provider.loadingStatus) {
                case LoadingStatus.loading:
                  return const RequestLoading();
                case LoadingStatus.failed:
                  return RequestLoadingFailed(onRetry: () {
                    requestComment(_currentArtworkId);
                  });
                case LoadingStatus.success:
              }
              return Column(
                children: [
                  // 评论区
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.all(4.0),
                      child: Builder(
                        builder: (_) {
                          if (_commentList.isEmpty) {
                            return Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: const Text("暂无评论", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                            );
                          }
                          return _buildComments(detail);
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    ];
  }

  // 构建评论区
  Widget _buildComments(CommonIllust detail) {
    // 展示的评论数量，[0-3]
    int commentsShowSize = _commentList.length > 3 ? 3 : _commentList.length;
    List<Widget> commentWidgets = [];
    for (int i = 0; i < commentsShowSize; i++) {
      var item = _commentList[i];
      commentWidgets.add(CommentWidget(comment: item));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 评论列表（部分
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 12),
          child: Column(
            children: commentWidgets,
          ),
        ),
        const Divider(
          height: 1,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(RouteNames.comments.name, arguments: detail.id.toString());
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Text(
              "查看全部评论 >",
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  /// 高级收藏
  void submitAdvancedBookmark(AdvancedCollectArguments arguments) {
    LocalizationIntl intl = LocalizationIntl.of(context);
    _bookmarkProvider.setBookmarkStatus(BookmarkStatus.bookmarking);
    ApiIllusts()
        .addIllustBookmark(illustId: _currentArtworkId, tags: arguments.tags, restrict: arguments.restrict)
        .then((value) {
      if (value) {
        doCallBack(true);
        Fluttertoast.showToast(
            msg: arguments.isCollected ? intl.editCollectionSucceed : intl.addCollectSucceed,
            toastLength: Toast.LENGTH_LONG);
        _bookmarkProvider.setBookmarkStatus(BookmarkStatus.bookmarked);
      } else {
        Fluttertoast.showToast(
            msg: arguments.isCollected ? intl.editCollectionFailed : intl.addCollectFailed,
            toastLength: Toast.LENGTH_LONG);
      }
    }).catchError((error) {
      if (error is DioError && error.type == DioErrorType.cancel) return;
      Fluttertoast.showToast(
          msg: arguments.isCollected ? intl.editCollectionFailed : intl.addCollectFailed,
          toastLength: Toast.LENGTH_LONG);
      _bookmarkProvider.setBookmarkStatus(BookmarkStatus.notBookmark);
    });
  }

  /// 请求收藏操作
  Future requestBookmark(BookmarkStatus status) async {
    assert(status == BookmarkStatus.bookmarked || status == BookmarkStatus.notBookmark);
    LocalizationIntl intl = LocalizationIntl.of(context);
    bool isCollected = (status == BookmarkStatus.bookmarked);

    _bookmarkProvider.setBookmarkStatus(isCollected ? BookmarkStatus.unBookmarking : BookmarkStatus.bookmarking);
    Future<bool> request = isCollected
        ? ApiIllusts().deleteIllustBookmark(illustId: _currentArtworkId)
        : ApiIllusts().addIllustBookmark(illustId: _currentArtworkId);
    // 服务端返回的操作成功与否
    bool result = await request.catchError((_) {
      // 响应失败则恢复到原先的状态并提示
      _bookmarkProvider.setBookmarkStatus(status);
      Fluttertoast.showToast(
          msg: isCollected ? intl.addCollectFailed : intl.addCollectFailed, toastLength: Toast.LENGTH_LONG);
    });
    if (result) {
      // 操作成功
      // 执行回调
      doCallBack(!isCollected);
      Fluttertoast.showToast(
          msg: isCollected ? intl.removeCollectionSucceed : intl.addCollectSucceed, toastLength: Toast.LENGTH_LONG);
      _bookmarkProvider.setBookmarkStatus(isCollected ? BookmarkStatus.notBookmark : BookmarkStatus.bookmarked);
    } else {
      // 操作失败
      Fluttertoast.showToast(
          msg: "${intl.removeCollectionFailed}, (Maybe already un-collected)", toastLength: Toast.LENGTH_LONG);
      // 恢复到原先的状态
      _bookmarkProvider.setBookmarkStatus(status);
    }
  }

  /// 获取作品详情
  void requestArtworkDetail(String artworkId) {
    if (_fullLoadingStatus != LoadingStatus.loading) {
      // 让页面显示加载中
      setState(() {
        _fullLoadingStatus = LoadingStatus.loading;
      });
    }
    if (!_detailCancelToken.isCancelled) _detailCancelToken.cancel();
    _detailCancelToken = CancelToken();
    ApiIllusts().getIllustDetail(artworkId, cancelToken: _detailCancelToken).then((value) {
      setState(() {
        _artworkDetail = value;
        _fullLoadingStatus = LoadingStatus.success;
      });
    }).catchError((error) {
      if (error is DioError && error.type == DioErrorType.cancel) return;
      setState(() {
        _fullLoadingStatus = LoadingStatus.failed;
      });
    });
  }

  /// 获取评论（部分）
  Future requestComment(String artworkId) async {
    if (!_commentCancelToken.isCancelled) _commentCancelToken.cancel();
    _commentCancelToken = CancelToken();
    IllustComments data =
        await ApiIllusts().getIllustComments(artworkId, cancelToken: _commentCancelToken).catchError((error) {
      if (!(error is DioError && error.type == DioErrorType.cancel)) {
        _loadingProvider.setLoadingStatus(LoadingStatus.failed);
      }
    });
    _commentList.clear();
    _commentList.addAll(data.comments);
    _loadingProvider.setLoadingStatus(LoadingStatus.success);
  }

  /// 执行回调方法，传入操作结果
  void doCallBack(bool isCollected) {
    if (widget.model.callback != null) {
      // 执行回调
      widget.model.callback!(widget.model.artworkId, isCollected);
    }
  }

  @override
  void dispose() {
    if (!_detailCancelToken.isCancelled) _detailCancelToken.cancel();
    if (!_commentCancelToken.isCancelled) _detailCancelToken.cancel();
    super.dispose();
  }
}
