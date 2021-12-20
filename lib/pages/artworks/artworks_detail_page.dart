import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/pages/comments_page.dart';
import 'package:pixgem/request/api_illusts.dart';
import 'package:pixgem/store/history_store.dart';
import 'package:pixgem/widgets/FollowButton.dart';
import 'package:pixgem/widgets/comment.dart';
import 'package:provider/provider.dart';

class ArtWorksDetailPage extends StatefulWidget {
  late ArtworkDetailModel model; // 数据集

  ArtWorksDetailPage(Object arguments, {Key? key}) : super(key: key) {
    model = arguments as ArtworkDetailModel;
  }

  @override
  State<StatefulWidget> createState() {
    return new _ArtWorksDetailState();
  }
}

class _ArtWorksDetailState extends State<ArtWorksDetailPage> {
  ///初始化Provider
  _IllustDetailProvider _provider = _IllustDetailProvider();
  IllustCommentsProvider _providerComments = IllustCommentsProvider();

  static const String _referer = "https://www.pixiv.net";
  Key? _imgKey = Key(DateTime.now().millisecondsSinceEpoch.toString());

  @override
  Widget build(BuildContext context) {
    var info = widget.model.list[widget.model.index];
    return ChangeNotifierProvider(
      create: (BuildContext context) => _provider,
      child: Scaffold(
        body: Stack(
          children: [
            // 内容主体
            Builder(
              builder: (BuildContext context) {
                return Scrollbar(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          // 预览大图
                          _buildPreviewImage(context, info),
                          // 详细信息卡
                          Container(
                            width: double.infinity,
                            child: _buildInfoCard(context, info),
                          ),
                          // 评论区
                          Container(
                            width: double.infinity,
                            child: Card(
                              elevation: 2.0,
                              margin: EdgeInsets.all(4.0),
                              child: ChangeNotifierProvider(
                                create: (BuildContext context) => _providerComments,
                                child: Consumer(
                                  builder: (BuildContext context, IllustCommentsProvider provider, Widget? child) {
                                    if (provider.commentList == null)
                                      return Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(16),
                                        child: _buildLoading(context),
                                      );
                                    return _buildComments(context, provider, info);
                                  },
                                ),
                              ),
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0x98000000),
                    Color(0x0),
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
                    info.title,
                    style: TextStyle(fontSize: 18),
                  ),
                  titleTextStyle: TextStyle(color: Colors.white),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
                  // 状态栏亮度，对应影响到字体颜色（dark为白色字体）
                  leading: Builder(builder: (context) {
                    return IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                  }),
                )),
          ],
        ),
        // 悬浮收藏按钮
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            postBookmark(info).then((value) {
              Fluttertoast.showToast(msg: "操作成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
              widget.model.callback(widget.model.index, _provider.isBookmarked); // 执行回调，让上级列表更新收藏状态
            }).onError((error, stackTrace) {
              Fluttertoast.showToast(msg: "操作失败！$error", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
              print(error);
            });
          },
          backgroundColor: Colors.grey.shade50,
          child: Selector(
            builder: (BuildContext context, bool? isBookmarked, Widget? child) {
              bool flag; // 在获取新数据前后对是否收藏的判断依据
              if (isBookmarked == null) {
                // 未加载新数据，使用传递的旧数据
                flag = info.isBookmarked;
              } else {
                // 已获取到新数据，使用新的数据
                flag = isBookmarked;
              }
              return Icon(
                flag ? Icons.favorite : Icons.favorite_border_outlined,
                color: flag ? Colors.red : Colors.grey,
                size: 28,
              );
            },
            selector: (context, _IllustDetailProvider provider) {
              return provider.isBookmarked;
            },
          ),
        ),
      ),
    );
  }

  // 构建预览大图
  Widget _buildPreviewImage(BuildContext context, CommonIllust info) {
    return Consumer(builder: (BuildContext context, _IllustDetailProvider provider, Widget? child) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed("artworks_view", arguments: info);
        },
        child: CachedNetworkImage(
          imageUrl: info.imageUrls.large,
          key: _imgKey,
          httpHeaders: {"referer": _referer},
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
                    child: Text("加载失败，点击重试"),
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
                        child: Text(((process.progress ?? 0) * 100).toStringAsFixed(0) + "%"),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }

  // 构建详细信息卡
  Widget _buildInfoCard(BuildContext context, CommonIllust info) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
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
                    Navigator.of(context).pushNamed("user_detail",
                        arguments:
                            PreloadUserLeastInfo(info.user.id, info.user.name, info.user.profileImageUrls.medium));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        // 作者头像
                        ClipOval(
                          child: Image.network(
                            info.user.profileImageUrls.medium,
                            headers: {"Referer": _referer},
                            fit: BoxFit.cover,
                            width: 56,
                            height: 56,
                          ),
                        ),
                        // 作者昵称 + 发布时间。自适应填满剩余空间
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                // 作者昵称
                                Padding(
                                  padding: EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    info.user.name,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                padding: EdgeInsets.only(right: 4.0, left: 4.0),
                child: FollowButton(
                  isFollowed: info.user.isFollowed,
                  userId: info.user.id.toString(),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 2, right: 2, top: 8, bottom: 8),
                    child: Row(
                      children: [
                        // 点赞数
                        Expanded(flex: 1, child: Text("id: " + info.id.toString())),
                        // 收藏数
                        Expanded(
                            flex: 1,
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Icon(Icons.favorite, size: 18, color: Colors.blueGrey.shade300),
                              Text(" " + info.totalBookmarks.toString(),
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade400, fontSize: 15, fontWeight: FontWeight.w400)),
                            ])),
                        // 浏览数
                        Expanded(
                          flex: 1,
                          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Icon(Icons.remove_red_eye, size: 18, color: Colors.grey),
                            Text(" " + info.totalView.toString(), style: TextStyle(color: Colors.grey, fontSize: 14)),
                          ]),
                        ),
                      ],
                    )),
                // 简介，字段为comment
                Text(
                  info.caption,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
                // tags
                Builder(
                  builder: (BuildContext context) {
                    List<Widget> _tags = [];
                    // 遍历displayTags
                    info.tags.forEach((element) {
                      // tag标签
                      _tags.add(
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("search_result", arguments: element.name);
                          },
                          child: Text("#${element.name} ",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15)),
                        ),
                      );
                      // 标签的翻译文字
                      _tags.add(
                        Text("${element.translatedName}  "),
                      );
                    });
                    return Wrap(
                      children: _tags,
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
  Widget _buildComments(BuildContext context, IllustCommentsProvider provider, CommonIllust info) {
    // 展示的评论数量，[0-3]
    int commentsShowSize = provider.commentList!.length > 3 ? 3 : provider.commentList!.length;
    if (commentsShowSize == 0) {
      return Padding(
        padding: EdgeInsets.only(top: 12),
        child: Text("暂无评论", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      );
    }
    List<Widget> commentWidgets = [];
    for (int i = 0; i < commentsShowSize; i++) {
      var item = provider.commentList![i];
      commentWidgets.add(CommentWidget(comment: item));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 评论列表（部分
        Padding(
          padding: EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 12),
          child: Column(
            children: commentWidgets,
          ),
        ),
        Divider(
          height: 1,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("artworks_comments", arguments: info.id.toString());
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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

  /* 收藏或者取消收藏插画 */
  Future postBookmark(CommonIllust info) async {
    bool isSucceed = false; // 是否执行成功
    bool isBookmarked = _provider.isBookmarked;

    if (isBookmarked)
      isSucceed = await ApiIllusts().deleteIllustBookmark(illustId: info.id.toString());
    else
      isSucceed = await ApiIllusts().addIllustBookmark(illustId: info.id.toString());
    // 执行结果
    if (isSucceed)
      _provider.setBookmarked(!isBookmarked);
    else
      Future.error("Request bookmark failed!");
  }

  @override
  void initState() {
    super.initState();
    _provider.setData(widget.model.list[widget.model.index]);
    ApiIllusts().getIllustComments(illustId: widget.model.list[widget.model.index].id.toString()).then((value) {
      _providerComments.setAll(value.comments, value.nextUrl);
    });
    // 保存到历史记录，如果已有记录会拉到顶部（性能欠佳）
    HistoryStore.addIllust(widget.model.list[widget.model.index]);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/* Provider: IllustDetail
 */
class _IllustDetailProvider with ChangeNotifier {
  late bool isBookmarked; // 是否已经收藏

  void setData(CommonIllust newData) {
    isBookmarked = newData.isBookmarked;
    notifyListeners();
  }

  void setBookmarked(bool value) {
    isBookmarked = value;
    notifyListeners();
  }
}

///
/// 作品详情的Model
/// @param list
/// @param index
/// @param list
///
class ArtworkDetailModel {
  List<CommonIllust> list; // 作品列表，
  int index; // 当前浏览作品的索引
  Function(int index, bool isBookmarked) callback; // 执行回调，让上级列表更新收藏状态

  ArtworkDetailModel({required this.list, required this.index, required this.callback});
}
