import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/pages/login/widgets/login_settings_bottom_sheet.dart';
import 'package:artvier/pages/settings/about/provider/about_app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 登录引导页面，未登录、添加帐号会跳转到这里
class LoginWizardPage extends ConsumerStatefulWidget {
  const LoginWizardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginWizardPageState();
}

class _LoginWizardPageState extends BasePageState<LoginWizardPage> {
  int clickCount = 0;
  int requiredClicks = 5;
  double maxClickInterval = 500;
  int lastClickTime = 0;
  bool hideSettings = true;

// 连点操作
  void onTapDown(TapDownDetails details) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - lastClickTime <= maxClickInterval) {
      clickCount++;
    } else {
      clickCount = 1;
    }
    lastClickTime = currentTime;
    if (clickCount >= requiredClicks) {
      hideSettings = false;
      clickCount = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -
                      kToolbarHeight -
                      kToolbarHeight -
                      MediaQuery.of(context).padding.top,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: GestureDetector(
                          onTapDown: onTapDown,
                          child: Text(ref.watch(packageInfoProvider).whenOrNull(data: (data) => data.appName) ?? "",
                              style: const TextStyle(fontSize: 32)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              CupertinoButton(
                                color: colorScheme.primary,
                                minSize: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                onPressed: () => Navigator.pushNamed(context, RouteNames.loginWeb.name),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    i10n.webLogin,
                                    textAlign: TextAlign.center,
                                    style:
                                        textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24, bottom: 8),
                                child: Text(i10n.appShortTermsTitle, style: textTheme.titleSmall),
                              ),
                              Text(i10n.appShortTerms, style: textTheme.labelSmall),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: kToolbarHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlurButton(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    onPressed: () => BottomSheets.showCustomBottomSheet(
                      context: context,
                      child: LoginSettingsBottomSheet(hideSomeSettings: hideSettings),
                    ),
                    child: const Icon(Icons.settings),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
