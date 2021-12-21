import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/model_response/user/user_previews_list.dart';
import 'package:pixgem/request/api_base.dart';
import 'package:pixgem/request/api_user.dart';
import 'package:pixgem/widgets/user_previews_listview.dart';

class UserFollowingPage extends StatefulWidget {
  late final String userId;

  UserFollowingPage(Object arguments, {Key? key}) : super(key: key) {
    userId = arguments as String;
  }

  @override
  State<StatefulWidget> createState() => UserFollowingPageState();
}

class UserFollowingPageState extends State<UserFollowingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        floatHeaderSlivers: true,
        onlyOneScrollInBody: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              pinned: true,
              title: Text("关注列表"),
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
