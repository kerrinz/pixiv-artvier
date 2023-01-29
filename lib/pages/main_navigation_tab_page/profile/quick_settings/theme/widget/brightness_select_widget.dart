import 'package:flutter/material.dart';
import 'package:pixgem/l10n/localization_intl.dart';

/// 浅色或深色模式的选择项
class BrightnessSelectWidget extends StatelessWidget {
  const BrightnessSelectWidget({
    super.key,
    required this.brightness,
    required this.isSelected,
    required this.onTap,
  });

  final Brightness brightness;

  final bool isSelected;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = brightness == Brightness.light;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    var i10n = LocalizationIntl.of(context);
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          // 预览图
          Stack(
            children: [
              Container(
                width: 55,
                height: 100,
                decoration: BoxDecoration(
                  color: isLight ? const Color(0xfff7f7f7) : const Color(0xff222222),
                  border: isSelected ? Border.all(width: 2.0, color: colorScheme.primary) : null,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              if (isSelected)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(Icons.check_circle_rounded, color: colorScheme.primary),
                  ),
                )
            ],
          ),
          // 文字
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              isLight ? i10n.lightBrightness : i10n.dartBrightness,
              style: TextStyle(fontSize: 16, color: isSelected ? colorScheme.primary : null),
            ),
          ),
        ],
      ),
    );
  }
}
