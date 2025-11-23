import 'package:artvier/base/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlockingTagItem extends BasePage {
  const BlockingTagItem({
    super.key,
    required this.name,
    required this.isBlocked,
    this.checked,
    this.onTap,
    this.onTapButton,
    this.onCheckboxChange,
  });
 
  final String name;

  final bool isBlocked;

  final bool? checked;

  final VoidCallback? onTap;

  final VoidCallback? onTapButton;

  final void Function(bool? value)? onCheckboxChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme(context).surface,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSparkle.splashFactory,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(name),
                    ),
                  ),
                  Stack(
                    children: [
                      Opacity(
                        opacity: checked == null ? 1 : 0,
                        child: CupertinoButton(
                          onPressed: checked == null ? onTapButton : null,
                          minimumSize: Size(0, 0),
                          pressedOpacity: 1,
                          alignment: Alignment.center,
                          padding: EdgeInsets.zero,
                          color: isBlocked ? colorScheme(context).primary : colorScheme(context).surfaceBright,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              border: !isBlocked ? Border.all(color: colorScheme(context).primary, width: 1) : null,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: SizedBox(
                              height: 16,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  isBlocked ? l10n(context).unblock : l10n(context).blocking,
                                  style: textTheme(context).labelLarge?.copyWith(
                                      height: 1,
                                      color: isBlocked ? colorScheme(context).onPrimary : colorScheme(context).primary),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (checked != null)
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Checkbox(
                            value: checked,
                            onChanged: onCheckboxChange,
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
