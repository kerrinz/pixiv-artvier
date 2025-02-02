import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/user_vertical_listview/user_vertical_listview.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/model_response/user/common_user_previews.dart';
import 'package:artvier/pages/user/following/provider/user_following_provider.dart';

class UserFollowingPage extends BasePage {
  UserFollowingPage(Object arguments, {super.key})
      : userId = arguments as String;

  final String userId;

  /// 所有的 [Restrict] 选项
  static final restrictOptions = [Restrict.public, Restrict.private];

  /// 用户的关注列表
  late final userFollowingProvider = AsyncNotifierProvider.autoDispose<UserFollowingNotifier, List<CommonUserPreviews>>(() {
    return UserFollowingNotifier(userId: userId);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var l10n = LocalizationIntl.of(context);
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
        body: RefreshIndicator(
          onRefresh: () async => ref.read(userFollowingProvider.notifier).refresh(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Consumer(builder: (_, ref, __) {
                  Restrict restrict = ref.watch(userFollowingFilterProvider(userId));
                  return StatelessTextFlowFilter(
                    initialIndexes: {restrictOptions.indexOf(restrict)},
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Theme.of(context).colorScheme.primary.withAlpha(100)),
                    ),
                    unselectedDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Theme.of(context).colorScheme.background),
                    ),
                    selectedTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    textPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    onTap: (int tapIndex) =>
                        ref.read(userFollowingFilterProvider(userId).notifier).update((state) => restrictOptions[tapIndex]),
                    texts: [l10n.public, l10n.private],
                  );
                }),
              ),
              Expanded(
                child: Consumer(
                  builder: ((_, ref, __) {
                    return ref.watch(userFollowingProvider).when(
                        skipLoadingOnReload: false,
                        skipLoadingOnRefresh: false,
                        data: (data) => UserVerticalListView(
                              userList: data,
                              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              mainAxisSpacing: 12,
                              onLazyload: () async => ref.read(userFollowingProvider.notifier).next(),
                            ),
                        error: (_, __) => RequestLoadingFailed(
                            onRetry: () => ref.read(userFollowingProvider.notifier).reload()),
                        loading: () => const RequestLoading());
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
