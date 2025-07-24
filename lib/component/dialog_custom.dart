import 'package:artvier/global/logger.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DialogCustom {
  static void showSelectItemListDialog(BuildContext context, Column columnItems) {
    showGeneralDialog<int>(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.black26, // 遮罩层
          body: Stack(
            children: [
              GestureDetector(onTap: () => Navigator.of(context).pop()),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).dialogBackgroundColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      columnItems,
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: CupertinoButton(
                      //     child: const Text("确定"),
                      //     onPressed: () {},
                      //   ),
                      // ),
                      // 取消按钮
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.only(top: 8),
                        child: CupertinoButton(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.zero,
                          child: const Text(
                            "取消",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 打开外部链接的提示
Future<bool> showOpenLinkDialog(BuildContext context, String url) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(LocalizationIntl.of(context).promptTitle),
        content: Text.rich(TextSpan(text: LocalizationIntl.of(context).openLinkHint, children: [
          const TextSpan(text: '\n'),
          TextSpan(text: url, style: Theme.of(context).textTheme.bodySmall),
        ])),
        actions: <Widget>[
          TextButton(child: Text(LocalizationIntl.of(context).promptCancel), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: Text(LocalizationIntl.of(context).promptConform),
            onPressed: () async {
              if (!await launchUrlString(url, mode: LaunchMode.externalApplication)) {
                logger.e('Could not launch $url');
              }
            },
          ),
        ],
      );
    },
  );
  return result ?? false;
}
