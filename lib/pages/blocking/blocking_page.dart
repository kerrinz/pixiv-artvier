import 'package:artvier/business_component/listview/blocking_listview/blocking_users_listview.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/blocking/blocking_list.dart';
import 'package:artvier/model_response/user/common_user.dart';
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
                        onLazyload: () async {
                          return false;
                        },
                        onTapItem: (index) => onTapItem(data.mutedUsers, index),
                        onTapButton: (int index) => handleUnblock(data.mutedUsers[index].user),
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
                                child: Text(
                                    usersCheckedList.length == data.mutedUsers.length
                                        ? l10n.deselectAll
                                        : l10n.selectAll,
                                    style: textTheme.labelLarge),
                                onPressed: () {
                                  if (usersCheckedList.length == data.mutedUsers.length) {
                                    // 全不选
                                    ref.read(blockingUsersCheckedListProvider.notifier).update((_) => []);
                                  } else {
                                    // 全选
                                    ref
                                        .read(blockingUsersCheckedListProvider.notifier)
                                        .update((_) => List.generate(data.mutedUsers.length, (i) => i));
                                  }
                                },
                              ),
                              // 一键屏蔽
                              TextButton(
                                onPressed: usersCheckedList.isNotEmpty
                                    ? handleUnblockList(List.generate(
                                        usersCheckedList.length, (i) => data.mutedUsers[usersCheckedList[i]].user))
                                    : null,
                                child: Text(l10n.unblockSelected),
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

  ValueNotifier<bool> dialogLoading = ValueNotifier(false);

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

  handleUnblock(CommonUser user) {
    dialogLoading.value = false;
    showDialog<bool>(
      context: context,
      builder: (context) => ValueListenableBuilder<bool>(
        valueListenable: dialogLoading,
        builder: (_, loading, __) => AlertDialog(
          title: Text(l10n.promptTitle),
          content: Text(l10n.promptOfUnblock(user.name)),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.promptCancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: loading
                  ? null
                  : () {
                      Navigator.of(context).pop();
                      dialogLoading.value = true;
                      ref.read(blockingListProvider.notifier).unblock(userIds: [user.id.toString()]).whenComplete(() {
                        dialogLoading.value = false;
                        ref.read(blockingListProvider.notifier).reload();
                      });
                    },
              child: Wrap(
                spacing: 8,
                children: [
                  if (!loading) Text(l10n.promptConform),
                  if (loading)
                    SizedBox(width: 16, height: 16, child: const CircularProgressIndicator(strokeWidth: 1.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleUnblockList(List<CommonUser> users) {
    dialogLoading.value = false;
    showDialog<bool>(
      context: context,
      builder: (context) => ValueListenableBuilder<bool>(
        valueListenable: dialogLoading,
        builder: (_, loading, __) => AlertDialog(
          title: Text(l10n.promptTitle),
          content: Text(l10n.promptOfUnblockList(users.length)),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.promptCancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: loading
                  ? null
                  : () {
                      Navigator.of(context).pop();
                      dialogLoading.value = true;
                      ref
                          .read(blockingListProvider.notifier)
                          .unblock(userIds: List.generate(users.length, (index) => users[index].id.toString()))
                          .whenComplete(() {
                        dialogLoading.value = false;
                        ref.read(blockingListProvider.notifier).reload();
                      });
                    },
              child: Wrap(
                spacing: 8,
                children: [
                  if (!loading) Text(l10n.promptConform),
                  if (loading)
                    SizedBox(width: 16, height: 16, child: const CircularProgressIndicator(strokeWidth: 1.0)),
                ],
              ),
            ),
          ],
        ),
      ),
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
