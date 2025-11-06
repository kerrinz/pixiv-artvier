import 'package:artvier/base/base_page.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/image/enhance_network_image.dart';

class BlockingUserItem extends BasePage {
  const BlockingUserItem({
    super.key,
    required this.avatar,
    required this.name,
    required this.isBlocked,
    this.onTap,
    this.onTapButton,
  });

  final String avatar;

  final String name;

  final bool isBlocked;

  final VoidCallback? onTap;

  final VoidCallback? onTapButton;

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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    child: ClipOval(
                      child: EnhanceNetworkImage(
                        image: ExtendedNetworkImageProvider(
                          HttpHostOverrides().pxImgUrl(avatar),
                          headers: HttpHostOverrides().pximgHeaders,
                          cache: true,
                        ),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(name),
                    ),
                  ),
                  CupertinoButton(
                    onPressed: onTapButton,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
