import 'package:artvier/business_component/listview/blocking_listview/blocking_users_listview.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/blocking/blocking_list.dart';
import 'package:artvier/model_response/user/preload_user_least_info.dart';
import 'package:artvier/pages/blocking/blocking_page_arguments.dart';
import 'package:artvier/pages/blocking/provider.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';

class BlockingPage extends BaseStatefulPage {
  final BlockingPageArguments? arguments;

  const BlockingPage(Object? arguments, {super.key}) : arguments = arguments as BlockingPageArguments?;

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
          final blockingCheckedList = ref.watch(blockingCheckedListProvider);
          /// TODO: 为传入的users和tags，提供屏蔽设定
          return res.when(
            data: (data) => ValueListenableBuilder<bool>(
              valueListenable: isEditMode,
              builder: (_, isEdit, __) {
                return Column(
                  children: [
                    Expanded(
                      child: BlockingListView(
                        userList: data.mutedUsers,
                        tagList: data.mutedTags,
                        editMode: isEdit,
                        checkedList: blockingCheckedList,
                        onLazyload: () async {
                          return false;
                        },
                        onTapItem: (index) => onTapItem,
                        onTapButton: handleUnblock,
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
                                onPressed: handleSelectOrDeselectAll,
                                child: Text(
                                    blockingCheckedList.length == (data.mutedUsers.length + data.mutedTags.length)
                                        ? l10n.deselectAll
                                        : l10n.selectAll,
                                    style: textTheme.labelLarge),
                              ),
                              // 一键屏蔽
                              TextButton(
                                onPressed: blockingCheckedList.isNotEmpty ? handleUnblockList : null,
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

  handleSelectOrDeselectAll() {
    final blockingCheckedList = ref.read(blockingCheckedListProvider);
    final data = ref.read(blockingListProvider).valueOrNull;
    if (data == null) return;
    final fullLength = data.mutedUsers.length + data.mutedTags.length;
    if (blockingCheckedList.length == fullLength) {
      // 全不选
      ref.read(blockingCheckedListProvider.notifier).update((_) => []);
    } else {
      // 全选
      ref.read(blockingCheckedListProvider.notifier).update((_) => List.generate(fullLength, (i) => i));
    }
  }

  onTapItem(int index) {
    final data = ref.read(blockingListProvider).valueOrNull;
    if (data == null) return;
    if (index < data.mutedUsers.length) {
      final item = data.mutedUsers[index];
      Navigator.of(context).pushNamed(
        RouteNames.userDetail.name,
        arguments: PreloadUserLeastInfo(item.user.id.toString(), item.user.name, item.user.profileImageUrls.medium),
      );
    }
  }

  handleUnblock(int index) {
    final data = ref.read(blockingListProvider).valueOrNull;
    if (data == null) return;
    if (index < data.mutedUsers.length) {
      final user = data.mutedUsers[index].user;
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
    } else {
      final metedTag = data.mutedTags[index];
      showDialog<bool>(
        context: context,
        builder: (context) => ValueListenableBuilder<bool>(
          valueListenable: dialogLoading,
          builder: (_, loading, __) => AlertDialog(
            title: Text(l10n.promptTitle),
            content: Text(l10n.promptOfUnblock(metedTag.tag.name)),
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
                            .unblock(tags: [metedTag.tag.name.toString()]).whenComplete(() {
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
  }

  handleUnblockList() {
    final data = ref.read(blockingListProvider).valueOrNull;
    if (data == null) return;
    final blockingCheckedList = ref.read(blockingCheckedListProvider);
    List<MutedUser> users = [];
    List<MutedTag> tags = [];
    for (var i = 0; i < blockingCheckedList.length; i++) {
      final index = blockingCheckedList[i];
      if (i < data.mutedUsers.length) {
        users.add(data.mutedUsers[index]);
      } else {
        tags.add(data.mutedTags[index]);
      }
    }
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
                          .unblock(userIds: List.generate(users.length, (index) => users[index].user.id.toString()))
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
    final state = ref.read(blockingCheckedListProvider).toSet().toList();
    if (value) {
      if (!state.contains(index)) {
        state.add(index);
      }
      ref.read(blockingCheckedListProvider.notifier).update((old) => state);
    } else {
      if (state.contains(index)) {
        state.remove(index);
      }
      ref.read(blockingCheckedListProvider.notifier).update((old) => state);
    }
  }
}
