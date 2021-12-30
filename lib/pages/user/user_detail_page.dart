import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/model_response/user/user_detail.dart';
import 'package:pixgem/pages/artworks/illusts_grid_page.dart';
import 'package:pixgem/request/api_base.dart';
import 'package:pixgem/request/api_user.dart';
import 'package:pixgem/widgets/follow_button.dart';
import 'package:pixgem/widgets/tab_bar_delegate.dart';
import 'package:provider/provider.dart';

class UserDetailPage extends StatefulWidget {
  late final PreloadUserLeastInfo leastInfo;

  UserDetailPage(Object arguments, {Key? key}) : super(key: key) {
    leastInfo = arguments as PreloadUserLeastInfo;
  }

  @override
  State<StatefulWidget> createState() {
    return _UserDetailState();
  }
}

class _UserDetailState extends State<UserDetailPage> with TickerProviderStateMixin {
  final _UserDetailProvider _provider = _UserDetailProvider();
  late TabController _tabController;

  static const List<Tab> _tabs = [
    Tab(text: "作品"),
    Tab(text: "收藏"),
    Tab(text: "其他信息"),
  ];
  // 用户信息简化列表的图标
  static const double coverHeight = 135; // 用户封面背景高度

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: _tabs.length, vsync: this);
    refreshUserData().catchError((onError) {
      Fluttertoast.showToast(msg: "获取用户数据失败！$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    }).whenComplete(() {
      _provider.setIsLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _provider,
      child: Scaffold(
        body: ExtendedNestedScrollView(
          onlyOneScrollInBody: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: coverHeight + 100,
                collapsedHeight: kToolbarHeight,
                // title: Text(widget.leastInfo.name),
                backgroundColor: Theme.of(context).bottomAppBarColor, // 与TabBar背景色一致
                shadowColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // 封面背景图
                      Selector(
                        selector: (context, _UserDetailProvider provider) {
                          return provider.userDetail;
                        },
                        builder: (BuildContext context, UserDetail? userDetail, Widget? child) {
                          if (userDetail == null || userDetail.profile.backgroundImageUrl == null) {
                            return Container(height: coverHeight, color: Colors.blueGrey);
                          }
                          return Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: coverHeight,
                                child: CachedNetworkImage(
                                  imageUrl: userDetail.profile.backgroundImageUrl!,
                                  httpHeaders: const {"Referer": CONSTANTS.referer},
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      // 蒙板
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: coverHeight,
                        child: Container(
                          color: const Color(0x33000000), // black with 0.2 opacity
                        ),
                      ),
                      // 是否已关注的按钮
                      Positioned(
                        top: coverHeight,
                        right: 0,
                        child: Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.only(right: 12),
                          child: Selector(
                            builder: (BuildContext context, bool? isFollowed, Widget? child) {
                              if (isFollowed == null) {
                                return OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    primary: Theme.of(context).colorScheme.onPrimary,
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                  ),
                                  child: const Text("loading..."),
                                );
                              }
                              return FollowButton(
                                isFollowed: isFollowed,
                                userId: widget.leastInfo.id.toString(),
                              );
                            },
                            selector: (context, _UserDetailProvider provider) {
                              return provider.isFollowedAuthor;
                            },
                          ),
                        ),
                      ),
                      // 显示用户的基础信息
                      Container(
                        padding: const EdgeInsets.only(top: coverHeight - 40, left: 12, right: 12),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            // 头像
                            Container(
                              width: 88,
                              height: 88,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(80)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    widget.leastInfo.avatar,
                                    headers: {"Referer": CONSTANTS.referer},
                                  ),
                                ),
                              ),
                            ),
                            // 昵称、关注、好P友
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6, bottom: 6),
                                  child: Text(
                                    widget.leastInfo.name,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Consumer(builder: (context, _UserDetailProvider provider, child) {
                                  if (provider.userDetail == null) {
                                    return const Text.rich(
                                      TextSpan(
                                        style: TextStyle(fontWeight: FontWeight.w300),
                                        children: [
                                          TextSpan(text: "关注 ?  "),
                                          TextSpan(text: "粉丝 ?"),
                                        ],
                                      ),
                                    );
                                  }
                                  return Text.rich(
                                    TextSpan(
                                      style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                                      children: [
                                        TextSpan(text: "关注 ${provider.userDetail!.profile.totalFollowUsers}  "),
                                        TextSpan(text: "好P友 ${provider.userDetail!.profile.totalMypixivUsers}"),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // TabBar 分页栏
              SliverPersistentHeader(
                pinned: true,
                delegate: TabBarDelegate(
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: false,
                    tabs: _tabs,
                  ),
                ),
              ),
            ];
          },
          // 分页页面
          body: TabBarView(
            controller: _tabController,
            children: [
              // 作品列表
              IllustGridTabPage(
                physics: const BouncingScrollPhysics(),
                onLazyLoad: (String nextUrl) async {
                  var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
                  return CommonIllustList.fromJson(result);
                },
                onRefresh: () async {
                  // 获取作品列表
                  return await ApiUser().getUserIllusts(userId: widget.leastInfo.id).catchError((onError) {
                    Fluttertoast.showToast(msg: "获取用户数据失败！$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                  });
                },
              ),
              // 收藏列表
              IllustGridTabPage(
                physics: const BouncingScrollPhysics(),
                onLazyLoad: (String nextUrl) async {
                  var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
                  return CommonIllustList.fromJson(result);
                },
                onRefresh: () async {
                  // 获取收藏列表
                  return await ApiUser().getUserBookmarksIllust(userId: widget.leastInfo.id).catchError((onError) {
                    Fluttertoast.showToast(msg: "获取用户数据失败！$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                  });
                },
              ),
              // tab——其他信息
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 16, right: 16, bottom: 8),
                      child: Text(
                        "个人介绍",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Card(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          child: Selector(
                            builder: (BuildContext context, UserDetail? detail, Widget? child) {
                              if (detail == null) {
                                return _buildLoading(context);
                              }
                              return Text.rich(
                                TextSpan(
                                  text: detail.user.comment,
                                ),
                                textAlign: TextAlign.left,
                              );
                            },
                            selector: (context, _UserDetailProvider provider) {
                              return provider.userDetail;
                            },
                          ),
                        ),
                      ),
                    ),
                    // 用户信息，图标列表
                    Selector(
                      builder: (BuildContext context, UserDetail? detail, Widget? child) {
                        if (detail == null) {
                          return Container();
                        }
                        Map<IconData, String> map = {
                          Icons.transgender: detail.profile.gender == "" ? "unknown" : detail.profile.gender,
                          Icons.home_filled: detail.profile.webpage ?? "unknown",
                          Icons.location_on: detail.profile.region == "" ? "unknown" : detail.profile.region,
                          Icons.comment: detail.profile.twitterUrl ?? "unknown",
                        };
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var iconKey = map.keys.elementAt(index);
                            return Row(
                              children: [
                                Padding(padding: const EdgeInsets.all(16.0), child: Icon(iconKey)),
                                Expanded(flex: 1, child: Text(map[iconKey] ?? "unknown")),
                              ],
                            );
                          },
                          itemCount: map.length,
                        );
                      },
                      selector: (context, _UserDetailProvider provider) {
                        return provider.userDetail;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建循环加载动画
  Widget _buildLoading(BuildContext context) {
    return Container(
      // width: 24.0,
      // height: 24.0,
      alignment: Alignment.center,
      child: CircularProgressIndicator(strokeWidth: 2.0, color: Theme.of(context).colorScheme.secondary),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  // 获取or刷新用户信息
  Future refreshUserData() async {
    UserDetail userDetail = await ApiUser().getUserDetail(userId: widget.leastInfo.id);
    _provider.setUserDetail(userDetail);
    _provider.setFollowed(userDetail.user.isFollowed);
  }

  // 关注或者取消关注用户
  Future postFollow() async {
    bool isSucceed = false;
    if (_provider.isFollowedAuthor!) {
      isSucceed = await ApiUser().deleteFollowUser(userId: widget.leastInfo.id);
    } else {
      isSucceed = await ApiUser().addFollowUser(userId: widget.leastInfo.id);
    }
    if (isSucceed) {
      _provider.setFollowed(!_provider.isFollowedAuthor!);
    } else {
      Future.error("Request follow failed!");
    }
  }
}

/* Provider: IllustDetail
 */
class _UserDetailProvider with ChangeNotifier {
  UserDetail? userDetail;
  bool isLoading = true; // 是否正在加载
  bool? isFollowedAuthor; // 是否已经关注作者

  void setUserDetail(UserDetail newData) {
    userDetail = newData;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setFollowed(bool value) {
    isFollowedAuthor = value;
    notifyListeners();
  }
}
