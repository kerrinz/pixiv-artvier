import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/business_component/listview/user_vertical_listview/user_vertical_listview.dart';
import 'package:pixgem/common_provider/lazyload_status_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/model_response/user/user_previews_list.dart';
import 'package:pixgem/base/base_api.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/pages/user/following/user_list_vertical_provider.dart';
import 'package:provider/provider.dart' as pro;

class UserFollowingPage extends ConsumerStatefulWidget {
  final String userId;

  const UserFollowingPage(Object arguments, {Key? key})
      : userId = arguments as String,
        super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => UserFollowingPageState();
}

class UserFollowingPageState extends ConsumerState<UserFollowingPage> {
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
        body: pro.MultiProvider(
          providers: [
            pro.ChangeNotifierProvider.value(value: _listProvider),
            pro.ChangeNotifierProvider.value(value: _lazyloadProvider),
          ],
          child: pro.Consumer(
            builder: ((_, UserListVerticalProvider provider, __) {
              if (provider.loadingStatus != LoadingStatus.success) {
                return RequestLoadMask(
                  loadingStatus: provider.loadingStatus,
                  onRetry: () {},
                );
              }
              return RefreshIndicator(
                onRefresh: refresh,
                child: UserVerticalListView(
                  userList: provider.userList,
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  mainAxisSpacing: 12,
                  onLazyload: () async {
                    if (provider.nextUrl == null) return false;
                    isLazyloading = true;
                    lazyload()
                        .catchError((_) => _lazyloadProvider.setLazyloadStatus(LazyloadStatus.failed))
                        .whenComplete(() => isLazyloading = false);
                    return false;
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
    UserPreviewsList data = await ApiUser(ref.read(httpRequesterProvider))
        .getUserFollowing(widget.userId)
        .catchError((error) => _listProvider.setLoadingStatus(LoadingStatus.failed));
    _listProvider.resetList(data.userPreviews, data.nextUrl);
  }

  Future lazyload() async {
    Map<String, dynamic> map = await ApiBase(ref.read(httpRequesterProvider)).nextUrlData(_listProvider.nextUrl!);
    UserPreviewsList data = UserPreviewsList.fromJson(map);
    _listProvider.appendList(data.userPreviews, data.nextUrl);
  }
}
