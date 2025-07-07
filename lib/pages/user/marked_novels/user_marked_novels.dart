import 'package:artvier/business_component/listview/marked_novel_listview/marked_novel_list.dart';
import 'package:artvier/model_response/novels/marker_novel.dart';
import 'package:artvier/pages/user/marked_novels/provider/user_marked_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/l10n/localization_intl.dart';

class UserMarkedPage extends BasePage {
  UserMarkedPage({super.key});

  /// 用户的书签列表
  late final useMarkedNovelsrovider = AsyncNotifierProvider.autoDispose<UserMarkedNotifier, List<MarkedNovel>>(() {
    return UserMarkedNotifier();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var l10n = LocalizationIntl.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.markers),
        toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
        actions: const [],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.read(useMarkedNovelsrovider.notifier).refresh(),
        child: Consumer(
          builder: ((_, ref, __) {
            return ref.watch(useMarkedNovelsrovider).when(
                skipLoadingOnReload: false,
                skipLoadingOnRefresh: false,
                data: (data) => MarkedNovelListView(
                      novelList: data,
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      mainAxisSpacing: 12,
                      onLazyload: () async => ref.read(useMarkedNovelsrovider.notifier).next(),
                    ),
                error: (_, __) =>
                    RequestLoadingFailed(onRetry: () => ref.read(useMarkedNovelsrovider.notifier).reload()),
                loading: () => const RequestLoading());
          }),
        ),
      ),
    );
  }
}
