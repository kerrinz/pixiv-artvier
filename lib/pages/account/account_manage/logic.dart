import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/pages/account/account_manage/provider/account_manage_provider.dart';
import 'package:artvier/routes.dart';
import 'package:artvier/storage/model/account_profile.dart';

mixin AccountManagePageStateLogic {
  WidgetRef get ref;

  /// 添加帐号
  void handlePressedAdd() {
    Navigator.of(ref.context).pushNamed(RouteNames.wizard.name);
  }

  /// 点击了帐号卡片
  void handleTapAccountCard(AccountProfile profile) {
    ref.read(accountManageProvider.notifier).switchAccount(profile.user.id).catchError((e) {
      Fluttertoast.showToast(msg: "Error to Switch account!");
      logger.e(e);
    });
  }
}
