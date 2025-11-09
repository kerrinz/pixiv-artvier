import 'package:artvier/business_component/listview/blocking_listview/blocking_users_listview.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/blocking/blocking_list.dart';
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
                  child: isEdit ? Text(l10n.cancel) : Text(l10n.batchEdit),
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final res = ref.watch(blockingListProvider);
          final usersCheckedList = ref.watch(blockingUsersCheckedListProvider);
          return res.when(
            data: (data) => ValueListenableBuilder<bool>(
              valueListenable: isEditMode,
              builder: (_, isEdit, __) {
                return Column(
                  children: [
                    Expanded(
                      child: BlockingListView(
                        list: data.mutedUsers,
                        editMode: isEdit,
                        checkedList: usersCheckedList,
                        onTapItem: (index) => onTapItem(data.mutedUsers, index),
                        onTapButton: (int index) => handleUnblock('@${data.mutedUsers[index].user.name}'),
                        onCheckboxChange: (index, value) => onCheckboxChange(index, value),
                      ),
                    ),
                    if (isEdit)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                        ),
                        child: SafeArea(
                          bottom: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: Text(l10n.selectAll, style: textTheme.labelLarge),
                                onPressed: () {},
                              ),
                              TextButton(
                                child: Text(l10n.unblockSelected),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                );
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

  onTapItem(List<MutedUser> users, int index) {
    final item = users[index];
    Navigator.of(context).pushNamed(
      RouteNames.userDetail.name,
      arguments: PreloadUserLeastInfo(item.user.id.toString(), item.user.name, item.user.profileImageUrls.medium),
    );
  }

  handleUnblock(String name) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.promptTitle),
          content: Text(l10n.promptOfUnblock(name)),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.promptCancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(l10n.promptConform),
            ),
          ],
        );
      },
    );
  }

  onCheckboxChange(int index, bool? value) {
    if (value == null) return;
    final state = ref.read(blockingUsersCheckedListProvider).toSet().toList();

    if (value) {
      if (!state.contains(index)) {
        state.add(index);
      }
      ref.read(blockingUsersCheckedListProvider.notifier).update((old) => state);
    } else {
      if (state.contains(index)) {
        state.remove(index);
      }
      ref.read(blockingUsersCheckedListProvider.notifier).update((old) => state);
    }
  }
}
