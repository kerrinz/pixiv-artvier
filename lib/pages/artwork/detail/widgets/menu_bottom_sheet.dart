import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/bottom_sheet/close_bar.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 插画详情页的菜单
class ArtworkDetailMenu extends BasePage {
  const ArtworkDetailMenu({
    super.key,
    required this.detail,
  });

  final CommonIllust detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetCloseBar(onTapClose: () => Navigator.of(context).pop()),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 24),
            child: Row(
              children: [
                rowListItem(
                  context: context,
                  text: l10n(context).copyLink,
                  icon: const Icon(Icons.link_rounded),
                  onTap: () =>
                      Clipboard.setData(ClipboardData(text: CONSTANTS.referer_artworks_base + detail.id.toString()))
                          .then((value) {
                    if (context.mounted) {
                      Fluttertoast.showToast(
                        msg: l10n(context).copiedToClipboard,
                        toastLength: Toast.LENGTH_SHORT,
                        fontSize: 16.0,
                      );
                      Navigator.of(context).pop();
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rowListItem({required context, required void Function()? onTap, required String text, required Widget icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
              ),
              padding: const EdgeInsets.all(12),
              child: icon,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
