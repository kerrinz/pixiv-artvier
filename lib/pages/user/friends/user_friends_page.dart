import 'package:artvier/pages/user/friends/provider/user_friends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/user_vertical_listview/user_vertical_listview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/model_response/user/common_user_previews.dart';

class UserFriendsPage extends BasePage {
  UserFriendsPage(Object arguments, {super.key}) : userId = arguments as String;

  final String userId;

  /// 所有的 [Restrict] 选项
  static final restrictOptions = [Restrict.public, Restrict.private];

  /// 用户的关注列表
  late final userFriendsProvider = AsyncNotifierProvider.autoDispose<UserFriendsNotifier, List<CommonUserPreviews>>(() {
    return UserFriendsNotifier(userId: userId);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var l10n = LocalizationIntl.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.friends),
        toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
        actions: const [],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.read(userFriendsProvider.notifier).refresh(),
        child: Consumer(
          builder: ((_, ref, __) {
            return ref.watch(userFriendsProvider).when(
                skipLoadingOnReload: false,
                skipLoadingOnRefresh: false,
                data: (data) => UserVerticalListView(
                      userList: data,
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      mainAxisSpacing: 12,
                      onLazyload: () async => ref.read(userFriendsProvider.notifier).next(),
                    ),
                error: (_, __) => RequestLoadingFailed(onRetry: () => ref.read(userFriendsProvider.notifier).reload()),
                loading: () => const RequestLoading());
          }),
        ),
      ),
    );
  }
}
