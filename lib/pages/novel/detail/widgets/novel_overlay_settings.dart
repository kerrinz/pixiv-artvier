import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/component/slider/division_slider.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:artvier/pages/novel/detail/provider/novel_detail_provider.dart';
import 'package:artvier/pages/novel/detail/widgets/novel_pages_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 小说阅读的浮层设置
class NovelDetailOverlaySettings extends BaseStatefulPage {
  const NovelDetailOverlaySettings({
    super.key,
    required this.novelId,
    required this.webViewData,
    this.catalogCallback,
  });

  final String novelId;

  final NovelDetailWebView webViewData;
  final NovelCatalogCallback? catalogCallback;

  @override
  createState() => _NovelDetailOverlaySettingsState();
}

class _NovelDetailOverlaySettingsState extends BasePageState<NovelDetailOverlaySettings> {
  static const List<double> textSizeList = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

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
                              ref.read(novelViewerSettings.notifier).changeTextSize(10 + value * 20);
                            },
                            divisions: textSizeList);
                      }),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(novelViewerSettings.notifier).plusTextSize();
                  },
                  icon: const Icon(Icons.text_increase_rounded),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: 添加书签
                    Fluttertoast.showToast(msg: "暂未支持", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                  },
                  icon: const Icon(Icons.bookmark_add_outlined),
                ),
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
}
