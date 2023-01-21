import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 标签列表的标签项
class TagListItemWidget extends ConsumerWidget {
  /// 标签名
  final String name;

  /// 是否被选择
  final bool isRegistered;

  final Function onTap;

  const TagListItemWidget({
    super.key,
    required this.name,
    required this.isRegistered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        splashFactory: InkSparkle.splashFactory,
        splashColor: colorScheme.background,
        highlightColor: colorScheme.background,
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "#$name",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: isRegistered ? FontWeight.w600 : FontWeight.normal,
                      color: isRegistered ? colorScheme.primary : colorScheme.onSurface),
                ),
              ),
              Icon(
                isRegistered ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isRegistered ? colorScheme.primary : colorScheme.onSurface.withAlpha(50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
