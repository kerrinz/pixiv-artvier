import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/perference/perference_group.dart';
import 'package:artvier/component/perference/perference_item.dart';
import 'package:artvier/global/provider/version_and_update_provider.dart';
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
        title: Text(l10n.settings),
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
                          l10n.accountManage,
                          style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                        )),
                  ],
                ),
                PerferenceGroup(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  items: [
                    // 开发者
                    PerferenceItem(
                        onTap: () => Navigator.of(context).pushNamed(RouteNames.developerSettings.name),
                        icon: Icon(Icons.code, color: colorScheme.primary),
                        text: Text(
                          "Developer",
                          style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                        )),
                  ],
                ),
                PerferenceGroup(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  items: [
                    // 软件更新
                    PerferenceItem(
                      onTap: () => Navigator.of(context).pushNamed(RouteNames.checkUpdate.name),
                      icon: Icon(Icons.update_rounded, color: colorScheme.primary),
                      text: Text(
                        l10n.softwareUpdate,
                        style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                      ),
                      value: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Consumer(builder: (context, ref, child) {
                            final currentVersion = ref
                                .watch(packageInfoProvider)
                                .whenOrNull(data: (data) => data.version.split('-').first);
                            final release = ref.watch(globalLastVersionProvider).whenOrNull(data: (data) => data);
                            if (currentVersion != null && release != null && release.tagName != currentVersion) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: MyBadge(
                                  color: Colors.redAccent,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  child: Text("NEW", style: textTheme.labelSmall?.copyWith(color: Colors.white)),
                                ),
                              );
                            }
                            return const SizedBox();
                          }),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                    // 关于APP
                    PerferenceItem(
                        onTap: () => Navigator.of(context).pushNamed(RouteNames.aboutApp.name),
                        icon: Icon(Icons.info, color: colorScheme.primary),
                        text: Text(
                          l10n.aboutApp,
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
