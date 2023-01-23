import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/global/provider/current_account_provider.dart';
import 'package:pixgem/global/provider/themes_provider.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/routes.dart';

mixin ProfileTabPageLogic {
  WidgetRef get ref;

  LocalizationIntl get i10n => LocalizationIntl.of(ref.context);

  /// 点击切换主题模式
  Future<void> handleTapThemeMode(bool isDarkMode) async {
    ThemeMode themeMode = ref.read(globalThemeModeProvider);
    // 主题模式已跟随系统，弹窗警告
    if (themeMode == ThemeMode.system) {
      bool isCancel = true; // 用户是否取消
      await showDialog(
        context: ref.context,
        builder: (context) {
          return AlertDialog(
            title: Text(i10n.promptTitle),
            content: Text(i10n.themeModePromptContent),
            actions: <Widget>[
              TextButton(child: Text(i10n.promptCancel), onPressed: () => Navigator.pop(context)),
              TextButton(
                child: Text(i10n.promptConform),
                onPressed: () {
                  isCancel = false;
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      if (isCancel) return; // 取消则不变更主题模式
    }
    // 切换主题模式
    ref.read(globalThemeModeProvider.notifier).switchThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  /// 点击了用户卡片
  void handleTapUser() {
    var account = ref.read(globalCurrentAccountProvider);
    account != null
        ? Navigator.of(ref.context).pushNamed(
            RouteNames.userDetail.name,
            arguments: PreloadUserLeastInfo(
                account.user.id.toString(), account.user.name, account.user.profileImageUrls!.px170x170),
          )
        : Navigator.of(ref.context).pushNamed(RouteNames.wizard.name);
  }
}
