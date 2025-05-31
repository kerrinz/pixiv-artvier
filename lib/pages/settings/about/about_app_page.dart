import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/dialog_custom.dart';
import 'package:artvier/component/perference/perference_group.dart';
import 'package:artvier/component/perference/perference_item.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/global/provider/version_and_update_provider.dart';
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
        title: Text(l10n.aboutApp),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height -
              MediaQuery.paddingOf(context).top -
              MediaQuery.paddingOf(context).bottom,
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
                      text: Text(l10n.appVersion),
                      value: SelectableText(
                        ref.watch(packageInfoProvider).whenOrNull(data: (data) => data.version) ?? "",
                        style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    PerferenceItem(
                      text: Text(l10n.appAuthor),
                      value: SelectableText(
                        onTap: () => showOpenLinkDialog(context, CONSTANTS.app_author_url),
                        "@${CONSTANTS.app_author}",
                        style: textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary, decoration: TextDecoration.underline),
                      ),
                    ),
                    PerferenceItem(
                      text: Text(l10n.appProjectLink),
                      value: SelectableText(
                        onTap: () => showOpenLinkDialog(context, CONSTANTS.app_repo_url),
                        CONSTANTS.app_repo_url,
                        style: textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary, decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    children: [
                      Text(l10n.appShortTermsTitle, style: textTheme.titleSmall!.copyWith(height: 2)),
                      Text(l10n.appShortTerms, style: textTheme.labelSmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
