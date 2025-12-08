import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/series/series_navigation_model.dart';
import 'package:artvier/business_component/series/series_navigation_provider.dart';
import 'package:artvier/component/buttons/label_button.dart';
import 'package:artvier/config/enums.dart';
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
  late final AutoDisposeStateNotifierProvider<SeriesWatchButtonNotifier, SeriesNavigationModel>
      novelSeriesWatchButtonProvider;

  @override
  void initState() {
    novelSeriesWatchButtonProvider =
        StateNotifierProvider.autoDispose<SeriesWatchButtonNotifier, SeriesNavigationModel>((ref) {
      return SeriesWatchButtonNotifier(
          SeriesNavigationModel(seriesIsWatched: widget.seriesIsWatched, loadstate: LoadState.completed),
          seriesId: widget.seriesId,
          worksType: widget.worksType,
          ref: ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(novelSeriesWatchButtonProvider);
    return SeriesWatchButtonStateless(
      seriesIsWatched: value.seriesIsWatched,
      loadState: value.loadstate,
      onPressedWatchButton: () {
        final notifier = ref.read(novelSeriesWatchButtonProvider.notifier);
        value.seriesIsWatched ? notifier.removeSeriesFromWatchlist() : notifier.addSeriesToWatchlist();
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
