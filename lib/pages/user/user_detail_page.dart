import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/user/perload_user_least_info.dart';
import 'package:pixgem/model_response/user/user_detail.dart';
import 'package:pixgem/request/api_app.dart';
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
  _UserDetailProvider _userDetailProvider = new _UserDetailProvider();
  ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  List<Tab> _tabs = [
    Tab(text: "作品"),
    Tab(text: "收藏"),
    Tab(text: "其他信息"),
  ];
  static const double coverHeight = 120; // 用户封面背景高度

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: _tabs.length, vsync: this);
    refreshData().catchError((onError) {
      Fluttertoast.showToast(msg: "获取用户数据失败！$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    }).whenComplete(() {
      _userDetailProvider.setIsLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _userDetailProvider,
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 220,
              collapsedHeight: kToolbarHeight,
              // title: Text(widget.leastInfo.name),
              backgroundColor: Theme.of(context).bottomAppBarColor,
              shadowColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  child: Stack(
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
                              Container(
                                width: double.infinity,
                                height: coverHeight,
                                child: CachedNetworkImage(
                                  imageUrl: userDetail.profile.backgroundImageUrl!,
                                  httpHeaders: {"Referer": CONSTANTS.referer},
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
                          color: Color(0x33000000), // black with 0.2 opacity
                        ),
                      ),
                      // 是否已关注的按钮
                      Positioned(
                        top: coverHeight,
                        right: 0,
                        child: Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(right: 12),
                          child: Consumer(builder: (context, _UserDetailProvider provider, child) {
                            if (provider.userDetail == null)
                              return OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Theme.of(context).accentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                child: Text("loading"),
                              );
                            else {
                              bool isFollowed = provider.userDetail!.user.isFollowed;
                              return OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  primary: isFollowed ? Theme.of(context).unselectedWidgetColor : Colors.white,
                                  backgroundColor: isFollowed ? Theme.of(context).bottomAppBarColor : Theme.of(context).accentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                child: Text(isFollowed ? "已关注" : "+ 关注"),
                              );
                            }
                          }),
                        ),
                      ),
                      // 显示用户的基础信息
                      Column(
                        children: [
                          // 占位
                          Container(
                            height: coverHeight - 40,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              children: [
                                // 头像
                                Container(
                                  width: 88,
                                  height: 88,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12, width: 1),
                                    borderRadius: BorderRadius.all(Radius.circular(80)),
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
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Consumer(builder: (context, _UserDetailProvider provider, child) {
                                      if (provider.userDetail == null)
                                        return Text.rich(
                                          TextSpan(
                                            style: TextStyle(fontWeight: FontWeight.w300),
                                            children: [
                                              TextSpan(text: "关注 ?  "),
                                              TextSpan(text: "粉丝 ?"),
                                            ],
                                          ),
                                        );
                                      return Text.rich(
                                        TextSpan(
                                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                                          children: [
                                            TextSpan(text: "关注 ${provider.userDetail!.profile.totalFollowUsers}  "),
                                            TextSpan(text: "粉丝 ${provider.userDetail!.profile.totalMypixivUsers}"),
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
                    ],
                  ),
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
                backgroundColor: null,
              ),
            ),
            // 分页页面
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Text("cnm"),
                  Text("cnm"),
                  Text("cnm"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  Future refreshData() async {
    UserDetail userDetail = await ApiApp().getUserDetail(userId: widget.leastInfo.id);
    _userDetailProvider.setUserDetail(userDetail);
  }
}

/*
* TabBar实现吸附顶端效果所需的Delegate */
class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  Color? backgroundColor;

  TabBarDelegate({required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: this.backgroundColor ?? Theme.of(context).bottomAppBarColor,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

/* Provider: IllustDetail
 */
class _UserDetailProvider with ChangeNotifier {
  UserDetail? userDetail;
  bool isLoading = true; // 是否正在加载
  bool isFollowedAuthor = false; // 是否已经关注作者

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
