import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/component/slider/division_slider.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/marker_state_changed_arguments/marker_state_changed_arguments.dart';
import 'package:artvier/global/model/novel_viewer/novel_viewer_settings_model.dart';
import 'package:artvier/global/provider/novel_marker_provider.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:artvier/pages/novel/detail/provider/novel_detail_provider.dart';
import 'package:artvier/pages/novel/detail/widgets/novel_pages_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

typedef MarkerClickCallback = void Function(int page);

/// 小说阅读的浮层设置
class NovelDetailOverlaySettings extends BaseStatefulPage {
  const NovelDetailOverlaySettings({
    super.key,
    required this.novelId,
    required this.webViewData,
    this.catalogCallback,
    this.markerCallback,
  });

  final String novelId;

  final NovelDetailWebView webViewData;
  final NovelCatalogCallback? catalogCallback;

  /// 书签按钮的回调
  final void Function(MarkerClickCallback callback)? markerCallback;

  @override
  createState() => _NovelDetailOverlaySettingsState();
}

class _NovelDetailOverlaySettingsState extends BasePageState<NovelDetailOverlaySettings> {
  static const List<double> textSizeList = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

  String get novelId => widget.novelId;
  NovelWebViewNovel get novel => widget.webViewData.novel;

  late final markerStateProvider =
      StateNotifierProvider.autoDispose<MarkerStateNotifier, MarkerStateChangedArguments>((ref) {
    ref.listen<MarkerStateChangedArguments?>(globalNovelMarkerStateChangedProvider, (previous, next) {
      if (next != null && next.worksId == novelId) {
        ref.notifier.setMarkerState(next);
      }
    });

    return MarkerStateNotifier(
        MarkerStateChangedArguments(
            worksId: novelId,
            page: novel.marker?.page,
            state: novel.marker?.page != null ? MarkerState.marked : MarkerState.unmarked),
        ref: ref,
        novelId: novelId);
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom, left: 12, right: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    ref.read(novelViewerSettings.notifier).minusTextSize();
                  },
                  icon: const Icon(Icons.text_decrease_rounded),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 1,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                      ),
                      child: Consumer(builder: (context, ref, child) {
                        final settings = ref.watch(novelViewerSettings);
                        final value = settings.textSize < 10 ? 0.0 : (settings.textSize - 10) / 20.0;
                        return DivisionSlider(
                            value: value > 1 ? 1 : (value < 0 ? 0 : value),
                            onChanged: (double value) {
                              HapticFeedback.lightImpact();
                              ref.read(novelViewerSettings.notifier).changeTextSize(10 + value * 20);
                            },
                            divisions: textSizeList);
                      }),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    ref.read(novelViewerSettings.notifier).plusTextSize();
                  },
                  icon: const Icon(Icons.text_increase_rounded),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Consumer(builder: (context, ref, child) {
                final themeName = ref.watch(novelViewerSettings.select((state) => state.themeName));
                // final customTheme = ref.watch(novelViewerSettings.select((state) => state.customTheme));
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 16,
                  children: [
                    for (final item in CONSTANTS.viewer_themes.entries)
                      _swatchBackgroundItem(
                        theme: item.value,
                        checked: (themeName ?? 'default') == item.key,
                        onTap: () {
                          if (item.value == null) {
                            ref.read(novelViewerSettings.notifier).changePageTheme(null);
                          } else {
                            ref.read(novelViewerSettings.notifier).changePageTheme(item.key);
                          }
                        },
                      ),
                  ],
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Builder(builder: (context) {
                  IconData icon = Icons.bookmark;
                  Color? color = Colors.red;
                  final markerState = ref.watch(markerStateProvider.select((value) => value.state));
                  switch (markerState) {
                    case MarkerState.addingMarker:
                      icon = Icons.bookmark;
                      color = Colors.grey;
                      break;
                    case MarkerState.removingMarker:
                      icon = Icons.bookmark;
                      color = Colors.red.withValues(alpha: 0.5);
                      break;
                    case MarkerState.marked:
                      icon = Icons.bookmark;
                      color = Colors.red;
                      break;
                    case MarkerState.unmarked:
                      icon = Icons.bookmark_add_outlined;
                      color = null;
                      break;
                  }
                  return IconButton(
                    onPressed: widget.markerCallback != null ? () => widget.markerCallback!(handleClickMarker) : null,
                    icon: Icon(icon),
                    color: color,
                  );
                }),
                IconButton(
                  onPressed: () {
                    BottomSheets.showCustomBottomSheet<bool>(
                      context: ref.context,
                      exitOnClickModal: true,
                      enableDrag: false,
                      child: NovelPagesBottomSheet(
                        webViewData: widget.webViewData,
                        callback: widget.catalogCallback,
                      ),
                    );
                  },
                  icon: const Icon(Icons.format_list_bulleted_rounded),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 切换背景颜色的色块
  Widget _swatchBackgroundItem({required NovelViewerTheme? theme, bool checked = false, VoidCallback? onTap}) {
    final background = theme != null ? Color(theme.background) : colorScheme.surface;
    final foreground = theme != null ? Color(theme.foreground) : colorScheme.onSurface;
    return SizedBox(
      width: 32,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: 32,
              decoration: BoxDecoration(
                color: background,
                border: Border.all(color: foreground),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: Center(child: Icon(Icons.text_format_rounded, color: foreground)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: SizedBox(
              height: 2,
              width: double.infinity,
              child: checked ? DecoratedBox(decoration: BoxDecoration(color: colorScheme.primary)) : null,
            ),
          )
        ],
      ),
    );
  }

  void handleClickMarker(int page) {
    HapticFeedback.lightImpact();
    final state = ref.read(markerStateProvider).state;
    if (state == MarkerState.marked) {
      ref
          .read(markerStateProvider.notifier)
          .unmarker()
          .then((value) =>
              Fluttertoast.showToast(msg: l10n.removeMarkerSucceed, toastLength: Toast.LENGTH_SHORT, fontSize: 16.0))
          .catchError((_) =>
              Fluttertoast.showToast(msg: l10n.removeMarkerFailed, toastLength: Toast.LENGTH_SHORT, fontSize: 16.0));
    } else if (state == MarkerState.unmarked) {
      ref
          .read(markerStateProvider.notifier)
          .marker(page: page)
          .then((value) =>
              Fluttertoast.showToast(msg: l10n.addMarkerSucceed, toastLength: Toast.LENGTH_SHORT, fontSize: 16.0))
          .catchError((_) =>
              Fluttertoast.showToast(msg: l10n.addMarkerFailed, toastLength: Toast.LENGTH_SHORT, fontSize: 16.0));
    }
  }
}
