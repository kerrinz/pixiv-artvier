import 'package:artvier/business_component/listview/blocking_listview/blocking_users_listview.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/user/preload_user_least_info.dart';
import 'package:artvier/pages/blocking/provider.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';

class BlockingPage extends BaseStatefulPage {
  const BlockingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _BlockingPageState();
  }
}

class _BlockingPageState extends BasePageState<BlockingPage> with _BlockingPageLogic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarLeadingButtton(),
        titleSpacing: 0,
        title: Text(l10n.blockingSettings),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ValueListenableBuilder<bool>(
              valueListenable: isEditMode,
              builder: (_, isEdit, __) {
                return BlurButton(
                  onPressed: handlePressedEdit,
                  background: Colors.transparent,
                  child: isEdit ? Text(l10n.cancel) : Text(l10n.edit),
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final res = ref.watch(blockingListProvider);
          return res.when(
            data: (data) => BlockingListView(
              list: data.mutedUsers,
              onLazyload: () async {
                return false;
              },
              onTapItem: (int index) {
                final item = data.mutedUsers[index];
                Navigator.of(context).pushNamed(
                  RouteNames.userDetail.name,
                  arguments:
                      PreloadUserLeastInfo(item.user.id.toString(), item.user.name, item.user.profileImageUrls.medium),
                );
              },
              onTapButton: (int index) {
                //
              },
            ),
            error: (error, stackTrace) => Center(
              child: RequestLoadingFailed(onRetry: () => ref.invalidate(blockingListProvider)),
            ),
            loading: (() => Center(child: RequestLoading())),
          );
        },
      ),
    );
  }
}

mixin _BlockingPageLogic on BasePageState<BlockingPage> {
  @override
  WidgetRef get ref;

  ValueNotifier<bool> isEditMode = ValueNotifier(false);

  /// 编辑
  void handlePressedEdit() {
    HapticFeedback.lightImpact();
    isEditMode.value = !isEditMode.value;
  }
}
