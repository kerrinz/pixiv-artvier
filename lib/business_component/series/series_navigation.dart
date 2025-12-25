import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/series/series_watch_button.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/buttons/label_button.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/series_state_changed_arguments/series_state_changed_arguments.dart';
import 'package:artvier/global/provider/series_state_provider.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_detail_page_args.dart';
import 'package:artvier/pages/novel/series/model/arguments.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 小说系列导航卡片，自带状态
class NovelSeriesNavigation extends BaseStatefulPage {
  final NovelWebViewNovel novel;

  const NovelSeriesNavigation({
    super.key,
    required this.novel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NovelSeriesNavigationState();
}

class _NovelSeriesNavigationState extends BasePageState<NovelSeriesNavigation> {
  /// 小说系列追更按钮
  late final AutoDisposeStateNotifierProvider<SeriesStateNotifier, SeriesState> novelSeriesWatchButtonProvider;

  @override
  void initState() {
    if (widget.novel.seriesId != null) {
      novelSeriesWatchButtonProvider = StateNotifierProvider.autoDispose<SeriesStateNotifier, SeriesState>((ref) {
        ref.listen<SeriesStateChangedArguments?>(globalNovelSeriesStateChangedProvider, (previous, next) {
          if (next != null && next.seriesId == widget.novel.seriesId) {
            ref.notifier.setSeriesState(next.state);
          }
        });
        return SeriesStateNotifier(
          (widget.novel.seriesIsWatched ?? false) ? SeriesState.watched : SeriesState.notWatch,
          seriesId: widget.novel.seriesId!,
          worksType: WorksType.novel,
          ref: ref,
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(novelSeriesWatchButtonProvider);
    return NovelSeriesNavigationStateless(
      novel: widget.novel,
      seriesIsWatched: value == SeriesState.watched || value == SeriesState.adding,
      loadState:
          (value == SeriesState.watched || value == SeriesState.notWatch) ? LoadState.completed : LoadState.loading,
      onPressedWatchButton: () {
        final notifier = ref.read(novelSeriesWatchButtonProvider.notifier);
        if (value != SeriesState.watched && value != SeriesState.notWatch) return;
        value == SeriesState.watched ? notifier.removeWatch() : notifier.addWatch();
      },
    );
  }
}

/// 小说系列导航卡片
class NovelSeriesNavigationStateless extends BasePage {
  const NovelSeriesNavigationStateless({
    super.key,
    required this.novel,
    required this.loadState,
    required this.seriesIsWatched,
    this.onPressedWatchButton,
  });

  final NovelWebViewNovel novel;

  final LoadState loadState;

  final bool seriesIsWatched;

  final VoidCallback? onPressedWatchButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (novel.seriesNavigation == null) return SizedBox();
    final primaryColor = colorScheme(context).primary;
    final labelLarge = textTheme(context).labelLarge;
    final labelSmall = textTheme(context).labelSmall;
    final unavailableButtonLabelStyle = labelLarge?.copyWith(color: colorScheme(context).outline);
    final textLargeHeight = (labelLarge?.fontSize ?? 16) * (labelLarge?.height ?? 1);
    final textSmallHeight = (labelSmall?.fontSize ?? 12) * (labelSmall?.height ?? 1);
    final buttonHeight = textLargeHeight + textSmallHeight + 10;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme(context).surface,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        spacing: 12,
        children: [
          // 系列标题
          GestureDetector(
            onTap: () {
              Navigator.of(ref.context).pushNamed(
                RouteNames.novelSeriesDetail.name,
                arguments: NovelSeriesDetailPagePageArguments(
                  id: int.parse(novel.seriesId!),
                  title: novel.seriesTitle ?? '',
                  url: null,
                  user: null,
                ),
              );
            },
            child: Row(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyBadge(
                  color: const Color(0xfffeaf0f),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(l10n(context).series, style: labelSmall?.copyWith(color: Colors.white, height: 1)),
                ),
                Expanded(child: Text(novel.seriesTitle ?? "", style: textTheme(context).titleSmall)),
                Icon(Icons.keyboard_arrow_right_rounded, color: textTheme(context).titleSmall?.color?.withAlpha(150)),
              ],
            ),
          ),
          // 是否追更
          SeriesWatchButtonStateless(
            loadState: loadState,
            seriesIsWatched: seriesIsWatched,
            onPressedWatchButton: onPressedWatchButton,
          ),
          // 上一话、下一话
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: novel.seriesNavigation?.prevNovel != null
                    ? _buildPaginateButton(
                        context: context,
                        buttonHeight: buttonHeight,
                        child: Column(
                          children: [
                            Text(l10n(context).previousEpisode, style: labelLarge?.copyWith(color: primaryColor)),
                            Text(
                              novel.seriesNavigation!.prevNovel!.title + novel.seriesNavigation!.prevNovel!.title,
                              style: labelSmall?.copyWith(color: primaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(ref.context).pushNamed(
                            RouteNames.novelDetail.name,
                            arguments: NovelDetailPageArguments(
                                novelId: novel.seriesNavigation!.prevNovel!.id.toString(),
                                title: novel.seriesNavigation!.prevNovel!.title),
                          );
                        },
                      )
                    : _buildPaginateButton(
                        context: context,
                        buttonHeight: buttonHeight,
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(l10n(context).noPreviousEpisode, style: unavailableButtonLabelStyle),
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: novel.seriesNavigation?.nextNovel != null
                    ? _buildPaginateButton(
                        context: context,
                        buttonHeight: buttonHeight,
                        child: Column(
                          children: [
                            Text(l10n(context).nextEpisode, style: labelLarge?.copyWith(color: primaryColor)),
                            Text(
                              novel.seriesNavigation!.nextNovel!.title,
                              style: labelSmall?.copyWith(color: primaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(ref.context).pushNamed(
                            RouteNames.novelDetail.name,
                            arguments: NovelDetailPageArguments(
                                novelId: novel.seriesNavigation!.nextNovel!.id.toString(),
                                title: novel.seriesNavigation!.nextNovel!.title),
                          );
                        })
                    : _buildPaginateButton(
                        context: context,
                        buttonHeight: buttonHeight,
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(l10n(context).noNextEpisode, style: unavailableButtonLabelStyle),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildPaginateButton({
    required BuildContext context,
    required Widget child,
    VoidCallback? onPressed,
    double? buttonHeight,
  }) {
    final primaryColor = colorScheme(context).primary;
    return LabelButton(
      height: buttonHeight,
      width: double.infinity,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      disabled: onPressed == null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: colorScheme(context).background,
          border: Border.all(
              width: 1, color: onPressed != null ? primaryColor : colorScheme(context).outline.withAlpha(100)),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: onPressed != null ? primaryColor.withAlpha(32) : primaryColor.withAlpha(16),
          ),
          child: child,
        ),
      ),
    );
  }
}
