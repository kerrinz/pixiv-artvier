import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/lazyload_status_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/component/scroll_list/user_list_vertical.dart';
import 'package:pixgem/model_response/user/user_previews_list.dart';
import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/pages/user/following/user_list_vertical_provider.dart';
import 'package:provider/provider.dart';

class UserFollowingPage extends StatefulWidget {
  late final String userId;

  UserFollowingPage(Object arguments, {Key? key}) : super(key: key) {
    userId = arguments as String;
  }

  @override
  State<StatefulWidget> createState() => UserFollowingPageState();
}

class UserFollowingPageState extends State<UserFollowingPage> {
  final UserListVerticalProvider _listProvider = UserListVerticalProvider();

  final LazyloadStatusProvider _lazyloadProvider = LazyloadStatusProvider();

  bool isLazyloading = false;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        floatHeaderSlivers: true,
        onlyOneScrollInBody: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              title: const Text("关注列表"),
              toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
              actions: const [],
            ),
          ];
        },
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: _listProvider),
            ChangeNotifierProvider.value(value: _lazyloadProvider),
          ],
          child: Consumer(
            builder: ((_, UserListVerticalProvider provider, __) {
              if (provider.loadingStatus != LoadingStatus.success) {
                return RequestLoadMask(
                  loadingStatus: provider.loadingStatus,
                  onRetry: () {},
                );
              }
              return RefreshIndicator(
                onRefresh: refresh,
                child: UserVerticalList(
                  userList: provider.userList,
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  mainAxisSpacing: 12,
                  hasMore: provider.nextUrl != null,
                  onLazyLoad: () {
                    if (provider.nextUrl == null || isLazyloading) return;
                    isLazyloading = true;
                    lazyload()
                        .catchError((_) => _lazyloadProvider.setLazyloadStatus(LazyloadStatus.failed))
                        .whenComplete(() => isLazyloading = false);
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  /// 刷新数据
  Future refresh({String? label}) async {
    if (_listProvider.loadingStatus != LoadingStatus.success) _listProvider.setLoadingStatus(LoadingStatus.loading);
    UserPreviewsList data = await ApiUser()
        .getUserFollowing(widget.userId)
        .catchError((error) => _listProvider.setLoadingStatus(LoadingStatus.failed));
    _listProvider.resetList(data.userPreviews, data.nextUrl);
  }

  Future lazyload() async {
    Map<String, dynamic> map = await ApiBase().nextUrlData(nextUrl: _listProvider.nextUrl!);
    UserPreviewsList data = UserPreviewsList.fromJson(map);
    _listProvider.appendList(data.userPreviews, data.nextUrl);
  }
}
