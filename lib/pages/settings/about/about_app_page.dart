import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/dialog_custom.dart';
import 'package:artvier/component/perference/perference_group.dart';
import 'package:artvier/component/perference/perference_item.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/pages/settings/about/provider/about_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutAppPage extends ConsumerStatefulWidget {
  const AboutAppPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends BasePageState<AboutAppPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(i10n.aboutApp),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SelectableText(
                    ref.watch(packageInfoProvider).whenOrNull(data: (data) => data.appName) ?? "",
                    style: textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                PerferenceGroup(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  items: [
                    PerferenceItem(
                      text: Text(i10n.appVersion),
                      value: SelectableText(
                        ref.watch(packageInfoProvider).whenOrNull(data: (data) => data.version) ?? "",
                        style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    PerferenceItem(
                      text: Text(i10n.appAuthor),
                      value: GestureDetector(
                        onTap: () => showOpenLinkDialog(context, CONSTANTS.app_author_url),
                        child: Text(
                          "@${CONSTANTS.app_author}",
                          style: textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary, decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    PerferenceItem(
                      text: Text(i10n.appProjectLink),
                      value: GestureDetector(
                        onTap: () => showOpenLinkDialog(context, CONSTANTS.app_repo_url),
                        child: Text(
                          CONSTANTS.app_repo_url,
                          style: textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary, decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
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
