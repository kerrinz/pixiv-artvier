import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/pages/user/recommend/provider/recommend_users_provider.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/user_vertical_listview/user_vertical_listview.dart';
import 'package:artvier/component/loading/request_loading.dart';

class RecommendUsersPage extends BasePage {
  const RecommendUsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        floatHeaderSlivers: true,
        onlyOneScrollInBody: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              leading: const AppbarLeadingButtton(),
              title: Text(i10n(context).recommendUsers),
              toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
              actions: const [],
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async => ref.read(recommendUsersProvider.notifier).refresh(),
          child: Consumer(
            builder: (_, ref, __) {
              return ref.watch(recommendUsersProvider).when(
                  skipLoadingOnReload: false,
                  skipLoadingOnRefresh: false,
                  data: (data) => UserVerticalListView(
                        userList: data,
                        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        mainAxisSpacing: 12,
                        onLazyload: () async => ref.read(recommendUsersProvider.notifier).next(),
                      ),
                  error: (_, __) =>
                      RequestLoadingFailed(onRetry: () => ref.read(recommendUsersProvider.notifier).reload()),
                  loading: () => const RequestLoading());
            },
          ),
        ),
      ),
    );
  }
}
