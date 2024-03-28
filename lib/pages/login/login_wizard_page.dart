import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/dialog/token_login.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/proxy/proxy_bottom_sheet.dart';
import 'package:artvier/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 登录引导页面，未登录、添加帐号会跳转到这里
class LoginWizardPage extends BasePage {
  const LoginWizardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text("Artvier", style: TextStyle(fontSize: 32)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: 300,
                          child: CupertinoButton(
                            color: colorScheme(context).primary,
                            minSize: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            onPressed: () => Navigator.pushNamed(context, RouteNames.loginWeb.name),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                i10n(context).webLogin,
                                textAlign: TextAlign.center,
                                style: textTheme(context)
                                    .labelLarge
                                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: 300,
                          child: CupertinoButton(
                            color: colorScheme(context).secondaryContainer,
                            minSize: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            onPressed: () => showDialog<bool>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) => const TokenLoginDialog(),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                i10n(context).tokenLogin,
                                textAlign: TextAlign.center,
                                style: textTheme(context)
                                    .labelLarge
                                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              BottomSheets.showCustomBottomSheet(
                                context: context,
                                child: const ProxyOriginSettingsBottomSheet(),
                              );
                            },
                            child: Row(
                              children: [
                                Text(i10n(context).networkSettings),
                                const Icon(Icons.arrow_right_rounded),
                              ],
                            ),
                          ),
                        ],
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
                    onPressed: () => Navigator.of(context).pushNamed(RouteNames.developerSettings.name),
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
