import 'package:artvier/business_component/listview/muted_listview/muted_users_listview.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/muted/muted_list.dart';
import 'package:artvier/model_response/user/common_user.dart';
import 'package:artvier/model_response/user/preload_user_least_info.dart';
import 'package:artvier/pages/muted/muted_page_arguments.dart';
import 'package:artvier/pages/muted/provider.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';

class MutedPage extends BaseStatefulPage {
  final MutedPageArguments? arguments;

  const MutedPage(Object? arguments, {super.key}) : arguments = arguments as MutedPageArguments?;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MutedPageState();
  }
}

class _MutedPageState extends BasePageState<MutedPage> with _MutedPageLogic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const AppbarLeadingButtton(), titleSpacing: 0, title: Text(l10n.mutedSettings)),
      body: Consumer(
        builder: (context, ref, child) {
          final res = ref.watch(mutedListProvider);
          final muteCheckedList = ref.watch(muteCheckedListProvider);

          return res.when(
            data: (data) {
              final mutedUsers = data.mutedUsers;
              final mutedTags = data.mutedTags;
              final argUsers = widget.arguments?.users
                      .map((v) => mutedUsers.firstWhere((el) => el.user.id == v.id,
                          orElse: () => MutedUser(user: v, isPremiumSlot: false)))
                      .toList() ??
                  [];
              final argTags = widget.arguments?.tags
                      .map((v) => data.mutedTags.firstWhere((el) => el.tag.name == v.name,
                          orElse: () => MutedTag(tag: MutedTagInfo(name: v.name))))
                      .toList() ??
                  [];

              return ValueListenableBuilder<bool>(
                valueListenable: isEditMode,
                builder: (_, isEdit, __) {
                  return Column(
                    children: [
                      Expanded(
                        child: CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 12, bottom: 4),
                              sliver: SliverToBoxAdapter(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: colorScheme.surface,
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(l10n.mutedPageHint),
                                        Text(l10n.mutedPagePremiumHint1),
                                        Text(l10n.mutedPagePremiumHint2),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (argUsers.isNotEmpty || argTags.isNotEmpty)
                              SliverPadding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 12, bottom: 4),
                                sliver: SliverToBoxAdapter(
                                  child: Text(l10n.candidates, style: textTheme.titleMedium),
                                ),
                              ),
                            if (argUsers.isNotEmpty || argTags.isNotEmpty)
                              SliverMutedListView(
                                userList: argUsers,
                                tagList: argTags,
                                // editMode: isEdit,
                                // checkedList: muteCheckedList,
                                onLazyload: null,
                                onTapItem: (index) => onTapItem(argUsers[index].user),
                                onTapButton: (index) {
                                  if (index < argUsers.length) {
                                    final user = argUsers[index].user;
                                    (user.isAccessBlockingUser ?? false)
                                        ? handleUnmute(user: user)
                                        : handleMute(user: user);
                                  } else {
                                    final metedTag = argTags[index - argUsers.length];
                                    (metedTag.isAccessBlocking ?? false)
                                        ? handleUnmute(tagName: metedTag.tag.name)
                                        : handleMute(tagName: metedTag.tag.name);
                                  }
                                },
                                // onCheckboxChange: (index, value) => onCheckboxChange(index, value),
                              ),
                            if (argUsers.isNotEmpty || argTags.isNotEmpty)
                              SliverPadding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 4, bottom: 0),
                                sliver: SliverToBoxAdapter(
                                  child: Divider(color: colorScheme.outline.withAlpha(100)),
                                ),
                              ),
                            SliverPadding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 12, bottom: 4),
                              sliver: SliverToBoxAdapter(
                                child: Row(
                                  children: [
                                    Expanded(child: Text(l10n.muted, style: textTheme.titleMedium)),
                                    ValueListenableBuilder<bool>(
                                      valueListenable: isEditMode,
                                      builder: (_, isEdit, __) {
                                        return BlurButton(
                                          onPressed: handlePressedEdit,
                                          background: Colors.transparent,
                                          child: isEdit ? Text(l10n.cancel) : Text(l10n.batchEdit),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.only(bottom: 56),
                              sliver: SliverMutedListView(
                                userList: mutedUsers,
                                tagList: mutedTags,
                                editMode: isEdit,
                                checkedList: muteCheckedList,
                                onLazyload: () async {
                                  return false;
                                },
                                onTapItem: (index) =>
                                    (index < mutedUsers.length) ? onTapItem(mutedUsers[index].user) : null,
                                onTapButton: (index) {
                                  if (index < mutedUsers.length) {
                                    final user = mutedUsers[index].user;
                                    (user.isAccessBlockingUser ?? false)
                                        ? handleUnmute(user: user)
                                        : handleMute(user: user);
                                  } else {
                                    final metedTag = mutedTags[index - mutedUsers.length];
                                    (metedTag.isAccessBlocking ?? false)
                                        ? handleUnmute(tagName: metedTag.tag.name)
                                        : handleMute(tagName: metedTag.tag.name);
                                  }
                                },
                                onCheckboxChange: (index, value) => onCheckboxChange(index, value),
                              ),
                            ),
                          ],
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
                                      muteCheckedList.length == (mutedUsers.length + mutedTags.length)
                                          ? l10n.deselectAll
                                          : l10n.selectAll,
                                      style: textTheme.labelLarge),
                                ),
                                // 一键屏蔽
                                TextButton(
                                  onPressed: muteCheckedList.isNotEmpty ? handleUnmuteList : null,
                                  child: Text(l10n.unmuteSelected),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  );
                },
              );
            },
            error: (error, stackTrace) => Center(
              child: RequestLoadingFailed(onRetry: () => ref.invalidate(mutedListProvider)),
            ),
            loading: (() => Center(child: RequestLoading())),
          );
        },
      ),
    );
  }
}

mixin _MutedPageLogic on BasePageState<MutedPage> {
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
    final muteCheckedList = ref.read(muteCheckedListProvider);
    final data = ref.read(mutedListProvider).valueOrNull;
    if (data == null) return;
    final fullLength = data.mutedUsers.length + data.mutedTags.length;
    if (muteCheckedList.length == fullLength) {
      // 全不选
      ref.read(muteCheckedListProvider.notifier).update((_) => []);
    } else {
      // 全选
      ref.read(muteCheckedListProvider.notifier).update((_) => List.generate(fullLength, (i) => i));
    }
  }

  onTapItem(CommonUser user) {
    Navigator.of(context).pushNamed(
      RouteNames.userDetail.name,
      arguments: PreloadUserLeastInfo(user.id.toString(), user.name, user.profileImageUrls.medium),
    );
  }

  handleMute({CommonUser? user, String? tagName}) {
    assert(user == null || tagName == null);
    dialogLoading.value = false;
    if (user != null) {
      showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ValueListenableBuilder<bool>(
          valueListenable: dialogLoading,
          builder: (_, loading, __) => AlertDialog(
            title: Text(l10n.promptTitle),
            content: Text(l10n.promptOfMute(user.name)),
            actions: <Widget>[
              TextButton(
                child: Text(l10n.promptCancel),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                onPressed: loading
                    ? null
                    : () async {
                        dialogLoading.value = true;
                        ref.read(mutedListProvider.notifier).mute(userIds: [user.id.toString()]).then((_) {
                          return ref.read(mutedListProvider.notifier).reload();
                        }).whenComplete(() {
                          dialogLoading.value = false;
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
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
    } else if (tagName != null) {
      showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ValueListenableBuilder<bool>(
          valueListenable: dialogLoading,
          builder: (_, loading, __) => AlertDialog(
            title: Text(l10n.promptTitle),
            content: Text(l10n.promptOfMute(tagName)),
            actions: <Widget>[
              TextButton(
                child: Text(l10n.promptCancel),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                onPressed: loading
                    ? null
                    : () {
                        dialogLoading.value = true;
                        ref.read(mutedListProvider.notifier).mute(tags: [tagName]).then((_) {
                          return ref.read(mutedListProvider.notifier).reload();
                        }).whenComplete(() {
                          dialogLoading.value = false;
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
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

  handleUnmute({CommonUser? user, String? tagName}) {
    assert(user == null || tagName == null);
    dialogLoading.value = false;
    if (user != null) {
      showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ValueListenableBuilder<bool>(
          valueListenable: dialogLoading,
          builder: (_, loading, __) => AlertDialog(
            title: Text(l10n.promptTitle),
            content: Text(l10n.promptOfUnmute(user.name)),
            actions: <Widget>[
              TextButton(
                child: Text(l10n.promptCancel),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                onPressed: loading
                    ? null
                    : () {
                        dialogLoading.value = true;
                        ref.read(mutedListProvider.notifier).unmute(userIds: [user.id.toString()]).then((_) {
                          return ref.read(mutedListProvider.notifier).reload();
                        }).whenComplete(() {
                          dialogLoading.value = false;
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
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
    } else if (tagName != null) {
      showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ValueListenableBuilder<bool>(
          valueListenable: dialogLoading,
          builder: (_, loading, __) => AlertDialog(
            title: Text(l10n.promptTitle),
            content: Text(l10n.promptOfUnmute(tagName)),
            actions: <Widget>[
              TextButton(
                child: Text(l10n.promptCancel),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                onPressed: loading
                    ? null
                    : () {
                        dialogLoading.value = true;
                        ref.read(mutedListProvider.notifier).unmute(tags: [tagName]).then((_) {
                          return ref.read(mutedListProvider.notifier).reload();
                        }).whenComplete(() {
                          dialogLoading.value = false;
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
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

  handleUnmuteList() {
    final data = ref.read(mutedListProvider).valueOrNull;
    if (data == null) return;
    final muteCheckedList = ref.read(muteCheckedListProvider);
    List<MutedUser> users = [];
    List<MutedTag> tags = [];
    for (var i = 0; i < muteCheckedList.length; i++) {
      final index = muteCheckedList[i];
      if (i < data.mutedUsers.length) {
        users.add(data.mutedUsers[index]);
      } else {
        tags.add(data.mutedTags[index]);
      }
    }
    dialogLoading.value = false;
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ValueListenableBuilder<bool>(
        valueListenable: dialogLoading,
        builder: (_, loading, __) => AlertDialog(
          title: Text(l10n.promptTitle),
          content: Text(l10n.promptOfUnmuteList(users.length + tags.length)),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.promptCancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: loading
                  ? null
                  : () {
                      dialogLoading.value = true;
                      ref
                          .read(mutedListProvider.notifier)
                          .unmute(userIds: List.generate(users.length, (index) => users[index].user.id.toString()))
                          .then((_) {
                        return ref.read(mutedListProvider.notifier).reload();
                      }).whenComplete(() {
                        dialogLoading.value = false;
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
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
    final state = ref.read(muteCheckedListProvider).toSet().toList();
    if (value) {
      if (!state.contains(index)) {
        state.add(index);
      }
      ref.read(muteCheckedListProvider.notifier).update((old) => state);
    } else {
      if (state.contains(index)) {
        state.remove(index);
      }
      ref.read(muteCheckedListProvider.notifier).update((old) => state);
    }
  }
}
