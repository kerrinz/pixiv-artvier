import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/dialog_custom.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/component/perference/perference_group.dart';
import 'package:artvier/component/perference/perference_item.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/global/provider/version_and_update_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckUpdatePage extends ConsumerStatefulWidget {
  const CheckUpdatePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckUpdatePageState();
}

class _CheckUpdatePageState extends BasePageState<CheckUpdatePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(i10n.softwareUpdate),
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
                      text: Text(i10n.currentVersion),
                      value: SelectableText(
                        ref.watch(packageInfoProvider).whenOrNull(data: (data) => data.version.split('-').first) ?? "-",
                        style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final result = ref.watch(globalLastVersionProvider);
                      final currentVersion =
                          ref.watch(packageInfoProvider).whenOrNull(data: (data) => data.version.split('-').first);
                      return result.when(
                          data: (data) {
                            if (currentVersion != null && data.tagName != currentVersion) {
                              // 有新版本（也可能在等待加载当前版本号）
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 6, top: 0, bottom: 4),
                                        child: Text(
                                          data.tagName,
                                          style: textTheme.headlineMedium?.copyWith(color: colorScheme.primary),
                                        ),
                                      ),
                                      MyBadge(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        color: Colors.redAccent,
                                        child: Text("NEW", style: textTheme.labelSmall?.copyWith(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(i10n.downloadLink, style: textTheme.titleMedium),
                                  ),
                                  for (final asset in data.assets)
                                    _buildBulletLine(Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      child: SelectableText(
                                        onTap: () => showOpenLinkDialog(context, asset.browserDownloadUrl),
                                        asset.browserDownloadUrl,
                                        style: textTheme.bodySmall
                                            ?.copyWith(color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(i10n.changelog, style: textTheme.titleMedium),
                                  ),
                                  SelectionArea(
                                    child: MarkdownBody(
                                      data: data.body,
                                      selectable: false,
                                    ),
                                  ),
                                ],
                              );
                            }
                            // 当前已经是最新版本
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(i10n.currentIsLatestVersion, textAlign: TextAlign.center),
                            );
                          },
                          error: (error, stackTrace) {
                            final exception = error as DioException;
                            final statusCode = exception.response?.statusCode;
                            if (statusCode == 403) {
                              // API访问次数超过限制
                              return Wrap(
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                direction: Axis.horizontal,
                                children: [
                                  Text(i10n.checkUpdateLimitForGithubApi),
                                  GestureDetector(
                                    onTap: () => showOpenLinkDialog(context, CONSTANTS.app_repo_release_url),
                                    child: Text(
                                      CONSTANTS.app_repo_release_url,
                                      style: textTheme.bodyMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.secondary,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return RequestLoadingFailed(
                              onRetry: () => ref.read(globalLastVersionProvider.notifier).reload(),
                            );
                          },
                          loading: () => const RequestLoading());
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBulletLine(Widget text) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 4, left: 8, right: 16),
        child: Text(
          "\u2022",
          style: textTheme.bodyMedium,
        ),
      ),
      Expanded(
        child: text,
      )
    ]);
  }
}
