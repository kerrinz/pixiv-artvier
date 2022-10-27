import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/common_provider/bookmark_status_provider_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/common_provider/works_provider.dart';
import 'package:pixgem/component/base_provider_widget.dart';
import 'package:pixgem/component/bottom_sheet/bottom_sheets.dart';
import 'package:pixgem/component/buttons/follow_button.dart';
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
  final BookmarkStatusProvider _bookmarkProvider = BookmarkStatusProvider(bookmarkStatus: BookmarkStatus.notBookmark);

  /// 管理<评论+相关作品>整体的加载
  final LoadingRequestProvider _loadingProvider = LoadingRequestProvider();

  /// （仅无预载入数据即全屏加载时生效）管理整个页面的总体加载状态
  late LoadingStatus _fullLoadingStatus;

  CancelToken _detailCancelToken = CancelToken();

  CancelToken _commentCancelToken = CancelToken();

  Key? _imgKey = Key(DateTime.now().millisecondsSinceEpoch.toString());

  /// 存放作品详情（在[widget.model.detail]为空时才会用到）
  CommonIllust? _artworkDetail;

  /// 评论列表（仅显示部分）
  final List<Comments> _commentList = [];

  /// 作品id
  String get _currentArtworkId => widget.model.artworkId;

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    if (_fullLoadingStatus == LoadingStatus.loading) {
      return const RequestLoading();
    } else if (_fullLoadingStatus == LoadingStatus.failed) {
      return RequestLoadingFailed(onRetry: () {
        requestArtworkDetail(_currentArtworkId);
      });
    }
    // 加载成功或者使用已有的详情数据时
    CommonIllust detail = widget.model.detail ?? _artworkDetail!;
    return Scaffold(
      body: Stack(
        children: [
          // 内容主体
          Builder(
            builder: (BuildContext context) {
              return Scrollbar(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        // 预览大图
                        _buildPreviewImage(context, detail),
                        // 详细信息卡
                        SizedBox(
                          width: double.infinity,
                          child: _buildInfoCard(context, detail),
                        ),
                        // 评论和相关作品
                        ConstrainedBox(
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
                                              child: const Text("暂无评论",
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // 顶部阴影渐变区域
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).padding.top + kToolbarHeight,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0x98000000),
                  Color(0x00000000),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
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
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
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
        ],
      ),
      // 悬浮收藏按钮
      // TODO Feature: 收藏请求过程中，加入图标跳动动画
      floatingActionButton: ProviderWidget<BookmarkStatusProvider>(
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
              AdvancedCollectArguments? arguments = await BottomSheets.showCustomBottomSheet<AdvancedCollectArguments>(
                context: context,
                exitOnClickModal: false,
                enableDrag: false,
                child: AdvancedCollectBottomSheet(
                  isCollected: _bookmarkProvider.bookmarkStatus == BookmarkStatus.bookmarked ? true : false,
                  worksId: _currentArtworkId,
                  worksType: WorksType.illust,
                ),
              );
              if (arguments == null) return;
              submitAdvancedBookmark(arguments);
            }),
            child: FloatingActionButton(
              onPressed: () {
                if ([BookmarkStatus.bookmarked, BookmarkStatus.notBookmark]
                    .contains(_bookmarkProvider.bookmarkStatus)) {
                  requestBookmark(_bookmarkProvider.bookmarkStatus);
                }
              },
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
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
          );
        }),
      ),
    );
  }

  // 构建预览大图
  Widget _buildPreviewImage(BuildContext context, CommonIllust info) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteNames.artworkImagesPreview.name, arguments: info);
      },
      child: CachedNetworkImage(
        imageUrl: info.imageUrls.large,
        key: _imgKey,
        httpHeaders: const {"referer": CONSTANTS.referer},
        errorWidget: (context, url, error) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                alignment: Alignment.center,
                width: constraints.maxWidth,
                height: info.height / info.width * constraints.maxWidth,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _imgKey = Key(DateTime.now().millisecondsSinceEpoch.toString());
                    });
                  },
                  child: const Text("加载失败，点击重试"),
                ),
              );
            },
          );
        },
        // 加载时显示loading图标
        progressIndicatorBuilder: (BuildContext context, String url, DownloadProgress process) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                alignment: Alignment.center,
                width: constraints.maxWidth,
                height: info.height / info.width * constraints.maxWidth,
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
    );
  }

  // 构建详细信息卡
  Widget _buildInfoCard(BuildContext context, CommonIllust info) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 作者的简单信息栏，author
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteNames.userDetail.name,
                        arguments:
                            PreloadUserLeastInfo(info.user.id, info.user.name, info.user.profileImageUrls.medium));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        // 作者头像
                        ClipOval(
                          child: Image.network(
                            info.user.profileImageUrls.medium,
                            headers: const {"Referer": CONSTANTS.referer},
                            fit: BoxFit.cover,
                            width: 56,
                            height: 56,
                          ),
                        ),
                        // 作者昵称 + 发布时间。自适应填满剩余空间
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                // 作者昵称
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    info.user.name,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // 发布时间
                                Text(
                                  formatDate(DateTime.parse(info.createDate),
                                      [yyyy, '-', mm, '-', dd, ' ', HH, ':', mm, ':', ss]),
                                  style: TextStyle(color: Colors.grey.shade500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 关注或已关注的按钮
              Padding(
                padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                child: FollowButton(
                  isFollowed: info.user.isFollowed!,
                  userId: info.user.id.toString(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2, top: 8, bottom: 8),
                    child: Row(
                      children: [
                        // 点赞数
                        Expanded(flex: 1, child: Text("id: ${info.id}")),
                        // 收藏数
                        Expanded(
                            flex: 1,
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Icon(Icons.favorite, size: 18, color: Colors.blueGrey.shade300),
                              Text(" ${info.totalBookmarks}",
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade400, fontSize: 15, fontWeight: FontWeight.w400)),
                            ])),
                        // 浏览数
                        Expanded(
                          flex: 1,
                          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            const Icon(Icons.remove_red_eye, size: 18, color: Colors.grey),
                            Text(" ${info.totalView}", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                          ]),
                        ),
                      ],
                    )),
                // 简介，字段为comment
                Text(
                  info.caption,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 15),
                ),
                // tags
                Builder(
                  builder: (BuildContext context) {
                    List<Widget> tags = [];
                    // 遍历displayTags
                    for (var element in info.tags) {
                      // tag标签
                      tags.add(
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(RouteNames.searchResult.name, arguments: element.name);
                          },
                          child: Text("#${element.name} ",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15)),
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
          )
        ],
      ),
    );
  }

  // 构建评论区
  Widget _buildComments(CommonIllust info) {
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
            Navigator.of(context).pushNamed(RouteNames.comments.name, arguments: info.id.toString());
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

  // 构建循环加载动画
  Widget _buildLoading(BuildContext context) {
    return SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(strokeWidth: 2.0, color: Theme.of(context).colorScheme.secondary));
  }

  /// 高级收藏
  void submitAdvancedBookmark(AdvancedCollectArguments arguments) {
    LocalizationIntl intl = LocalizationIntl.of(context);
    _bookmarkProvider.setBookmarkStatus(BookmarkStatus.bookmarking);
    ApiIllusts()
        .addIllustBookmark(illustId: _currentArtworkId, tags: arguments.tags, restrict: arguments.restrict)
        .then((value) {
      if (value) {
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
          msg: isCollected ? intl.removeCollectionFailed : intl.addCollectFailed, toastLength: Toast.LENGTH_LONG);
    });
    if (result) {
      // 操作成功
      if (widget.model.callback != null) {
        // 执行回调
        widget.model.callback!(widget.model.artworkId, false);
      }
      Fluttertoast.showToast(msg: intl.removeCollectionSucceed, toastLength: Toast.LENGTH_LONG);
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
        _loadingProvider.setLazyloadStatus(LoadingStatus.failed);
      }
    });
    _commentList.clear();
    _commentList.addAll(data.comments);
    _loadingProvider.setLazyloadStatus(LoadingStatus.success);
  }

  @override
  void dispose() {
    if (!_detailCancelToken.isCancelled) _detailCancelToken.cancel();
    if (!_commentCancelToken.isCancelled) _detailCancelToken.cancel();
    super.dispose();
  }
}
