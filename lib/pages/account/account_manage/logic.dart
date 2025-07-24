import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/account/account_manage/account_manage_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/pages/account/account_manage/provider/account_manage_provider.dart';
import 'package:artvier/routes.dart';
import 'package:artvier/global/model/account_profile/account_profile.dart';

mixin AccountManagePageStateLogic on BasePageState<AccountManagePage> {
  @override
  WidgetRef get ref;

  ValueNotifier<bool> isEditMode = ValueNotifier(false);

  /// 编辑
  void handlePressedEdit() {
    HapticFeedback.lightImpact();
    isEditMode.value = !isEditMode.value;
  }

  ///删除
  handleTapDelete(AccountProfile profile, AccountProfile? currrentProfile) {
    HapticFeedback.lightImpact();
    showDialog<bool>(
      context: ref.context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.promptTitle),
          content: Text(l10n.deleteAccountPromptMessage(profile.user.name)),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.promptCancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: () async {
                final notifier = ref.read(accountManageProvider.notifier);
                await notifier.deleteAccount(profile.user.id);
                // 删除的是非当前账号
                if (profile.user.id != currrentProfile?.user.id) {
                  if (context.mounted) Navigator.of(context).pop();
                  return;
                }
                // 删除的是当前账号
                final accountList = ref.read(accountManageProvider);
                if (accountList.isEmpty) {
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(context, RouteNames.wizard.name, (route) => false);
                  }
                } else {
                  await notifier.switchAccount(accountList.entries.first.key);
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainNavigation.name, (route) => false);
                  }
                }
              },
              child: Text(l10n.promptConform),
            ),
          ],
        );
      },
    );
  }

  /// 点击了帐号卡片
  void handleTapAccountCard(AccountProfile profile) {
    HapticFeedback.lightImpact();
    ref.read(accountManageProvider.notifier).switchAccount(profile.user.id).then((value) {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainNavigation.name, (route) => false);
      }
    }).catchError((e) {
      Fluttertoast.showToast(msg: "Error to Switch account!");
      logger.e(e);
    });
  }

  void handleTapLoginOtherAccount() {
    HapticFeedback.lightImpact();
    Navigator.of(ref.context).pushNamed(RouteNames.wizard.name);
  }
}
