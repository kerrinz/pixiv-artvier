import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/perference/perference_group.dart';
import 'package:artvier/component/perference/perference_item.dart';
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
                PerferenceGroup(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  items: [
                    PerferenceItem(
                      text: const Text("App name"),
                      value: SelectableText(
                        ref.watch(packageInfoProvider).whenOrNull(data: (data) => data.appName) ?? "",
                        style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    PerferenceItem(
                      text: const Text("Version"),
                      value: SelectableText(
                        ref.watch(packageInfoProvider).whenOrNull(data: (data) => data.version) ?? "",
                        style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
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
