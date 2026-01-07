import 'package:artvier/base/base_page.dart';
import 'package:artvier/global/model/novel_viewer/novel_viewer_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 小说浏览页，主题色块
class NovelViewerSwatchesButton extends BasePage {
  const NovelViewerSwatchesButton({
    super.key,
    required this.theme,
    this.checked = false,
    this.onTap,
    this.colorWidth = 36.0,
  });

  final NovelViewerPresetTheme theme;
  final bool checked;
  final VoidCallback? onTap;

  /// 色块长度
  final double colorWidth;

  @override
  Widget build(BuildContext context, ref) {
    // 是否自定义主题
    final isCustomizeTheme = theme.name == 'custom';
    // 是否默认主题
    final isDefaultTheme = theme.name == 'default' || (!isCustomizeTheme && theme.theme == null);
    final background = isDefaultTheme ? colorScheme(context).surface : Color(theme.theme!.background);
    final foreground = isDefaultTheme ? colorScheme(context).onSurface : Color(theme.theme!.foreground);
    final width = (isDefaultTheme || isCustomizeTheme) ? null : colorWidth;
    final height = colorWidth;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: background,
                border: Border.all(color: foreground),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: Center(
                child: isDefaultTheme || isCustomizeTheme
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(theme.name!, style: textTheme(context).labelSmall),
                      )
                    : Icon(Icons.text_format_rounded, color: foreground),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: SizedBox(
              height: 4,
              width: 16,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: checked ? colorScheme(context).primary : null,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 小说浏览页，编辑自定义主题
class NovelViewerCustomizeThemeEditor extends BaseStatefulPage {
  const NovelViewerCustomizeThemeEditor({
    super.key,
    required this.theme,
    this.onConfirm,
  });

  final NovelViewerTheme? theme;

  final VoidCallback? onConfirm;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NovelViewerCustomizeThemeEditorState();
  }
}

class _NovelViewerCustomizeThemeEditorState extends BasePageState<NovelViewerCustomizeThemeEditor> {
  late NovelViewerTheme? theme;
  late int? foreground;
  late int? background;

  @override
  void initState() {
    theme = widget.theme;
    foreground = widget.theme?.foreground;
    background = widget.theme?.background;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        // 前景色
        Row(
          children: [
            Expanded(child: Text('${l10n.foregroundColor}: ')),
            _colorBadgeItem(
              onTap: () async {
                // create some values
                Color pickerColor = foreground != null ? Color(foreground!) : Colors.black;
                Color? resultColor;
                await showDialog(
                  builder: (context) => AlertDialog(
                    title: Text(l10n.foregroundColor),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: (Color color) {
                          pickerColor = color;
                        },
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: Text(l10n.promptConform),
                        onPressed: () {
                          resultColor = pickerColor;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  context: context,
                );
                if (resultColor != null) {
                  print(resultColor);
                }
              },
              color: foreground != null ? Color(foreground!) : null,
              text: foreground != null ? '0x${foreground!.toRadixString(16).toUpperCase()}' : l10n.edit,
            ),
          ],
        ),
        // 背景色
        Row(
          children: [
            Expanded(child: Text('${l10n.backgroundColor}: ')),
            _colorBadgeItem(
              onTap: () {},
              color: background != null ? Color(background!) : null,
              text: background != null ? '0x${background!.toRadixString(16).toUpperCase()}' : l10n.edit,
            ),
          ],
        ),
        // 预览
        if (background != null && foreground != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Color(theme!.background),
            ),
            child: Text('ABCDEFGHIJK', style: textTheme.bodyMedium?.copyWith(color: Color(foreground!))),
          ),
      ],
    );
  }

  Widget _colorBadgeItem({required Color? color, required String text, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 1, color: colorScheme.outline),
        ),
        child: Row(
          spacing: 4,
          children: [
            if (color != null)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  color: color,
                  border: Border.all(width: 1, color: colorScheme.onSurface),
                ),
              ),
            Text(text),
            Icon(Icons.edit_rounded, size: 16),
          ],
        ),
      ),
    );
  }
}
