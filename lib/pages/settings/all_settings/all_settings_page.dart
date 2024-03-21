import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/perference/perference_group.dart';
import 'package:artvier/component/perference/perference_item.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllSettingsPage extends ConsumerStatefulWidget {
  const AllSettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllSettingsPageState();
}

class _AllSettingsPageState extends BasePageState<AllSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(i10n.settings),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                // 账号相关
                PerferenceGroup(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  items: [
                    PerferenceItem(
                        onTap: () => Navigator.of(context).pushNamed(RouteNames.accountManage.name),
                        icon: Icon(Icons.switch_account, color: colorScheme.primary),
                        text: Text(
                          i10n.accountManage,
                          style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                        )),
                  ],
                ),
                // 开发者
                PerferenceGroup(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  items: [
                    PerferenceItem(
                        onTap: () => Navigator.of(context).pushNamed(RouteNames.developerSettings.name),
                        icon: Icon(Icons.code, color: colorScheme.primary),
                        text: Text(
                          "Developer",
                          style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                        )),
                    PerferenceItem(
                        onTap: () => Navigator.of(context).pushNamed(RouteNames.aboutApp.name),
                        icon: Icon(Icons.info, color: colorScheme.primary),
                        text: Text(
                          i10n.aboutApp,
                          style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
