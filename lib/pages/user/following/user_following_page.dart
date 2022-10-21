import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/model_response/user/user_previews_list.dart';
import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/api_app/api_user.dart';

import 'widget/user_previews_listview.dart';

class UserFollowingPage extends StatefulWidget {
  late final String userId;

  UserFollowingPage(Object arguments, {Key? key}) : super(key: key) {
    userId = arguments as String;
  }

  @override
  State<StatefulWidget> createState() => UserFollowingPageState();
}

class UserFollowingPageState extends State<UserFollowingPage> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        floatHeaderSlivers: true,
        onlyOneScrollInBody: true,
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              title: const Text("关注列表"),
              toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
              actions: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up),
                  onPressed: () {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  },
                  tooltip: "回到顶部",
                ),
              ],
            ),
          ];
        },
        body: UsersCardListView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          onLazyLoad: (String nextUrl) async {
            var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
            return UserPreviewsList.fromJson(result);
          },
          onRefresh: () async {
            return await ApiUser().getUserFollowing(userId: widget.userId);
          },
        ),
      ),
    );
  }
}
