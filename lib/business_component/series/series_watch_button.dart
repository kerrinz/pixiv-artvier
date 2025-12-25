import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/buttons/label_button.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/series_state_changed_arguments/series_state_changed_arguments.dart';
import 'package:artvier/global/provider/series_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 系列追更按钮，自带状态
class SeriesWatchButton extends BaseStatefulPage {
  final bool seriesIsWatched;
  final String seriesId;
  final WorksType worksType;

  const SeriesWatchButton({
    super.key,
    required this.seriesIsWatched,
    required this.seriesId,
    required this.worksType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeriesWatchButtonState();
}

class _SeriesWatchButtonState extends BasePageState<SeriesWatchButton> {
  /// 小说系列追更按钮
  late final AutoDisposeStateNotifierProvider<SeriesStateNotifier, SeriesState> novelSeriesWatchButtonProvider;

  @override
  void initState() {
    novelSeriesWatchButtonProvider = StateNotifierProvider.autoDispose<SeriesStateNotifier, SeriesState>((ref) {
      ref.listen<SeriesStateChangedArguments?>(globalNovelSeriesStateChangedProvider, (previous, next) {
        if (next != null && next.seriesId == widget.seriesId) {
          ref.notifier.setSeriesState(next.state);
        }
      });
      return SeriesStateNotifier(
        (widget.seriesIsWatched) ? SeriesState.watched : SeriesState.notWatch,
        seriesId: widget.seriesId,
        worksType: WorksType.novel,
        ref: ref,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(novelSeriesWatchButtonProvider);
    return SeriesWatchButtonStateless(
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

/// 系列追更按钮
class SeriesWatchButtonStateless extends BasePage {
  const SeriesWatchButtonStateless({
    super.key,
    required this.loadState,
    required this.seriesIsWatched,
    this.onPressedWatchButton,
  });

  final LoadState loadState;

  final bool seriesIsWatched;

  final VoidCallback? onPressedWatchButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = colorScheme(context).primary;
    final labelLarge = textTheme(context).labelLarge;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme(context).surface,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: LabelButton(
        width: double.infinity,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        padding: EdgeInsets.zero,
        onPressed: loadState == LoadState.loading ? null : onPressedWatchButton,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 1, color: primaryColor),
            color: seriesIsWatched ? null : primaryColor,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: loadState == LoadState.loading ? 0 : 1,
                child: Column(
                  children: [
                    Text(
                      seriesIsWatched ? l10n(context).alreadyInWatchlist : l10n(context).addToWatchlist,
                      style:
                          labelLarge?.copyWith(color: seriesIsWatched ? primaryColor : colorScheme(context).onPrimary),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: loadState == LoadState.loading ? 1 : 0,
                  child: Center(
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 1.0, color: seriesIsWatched ? null : colorScheme(context).onPrimary)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
