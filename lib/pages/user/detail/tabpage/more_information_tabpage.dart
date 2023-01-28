import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/user/user_detail.dart';

class UserMoreInformationTabPage extends ConsumerWidget {
  const UserMoreInformationTabPage({super.key, required this.detail});

  final UserDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var i10n = LocalizationIntl.of(context);
    String age = "";
    if (detail.profile.birthYear != 0 && detail.profile.birth != "") {
      DateTime? birth = DateTime.tryParse(detail.profile.birth);
      DateTime now = DateTime.now();
      if (birth != null) {
        int rectify = (now.month < birth.month || (now.month == birth.month && now.day < birth.day)) ? -1 : 0;
        age = (now.year - birth.year + rectify).toString();
      }
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            _buildMoreInfomationCard(
              context: context,
              title: '基本资料',
              leftRows: [
                i10n.nickname,
                i10n.age,
                i10n.birthday,
                i10n.location,
                i10n.occupation,
                i10n.pixivPremium,
              ],
              rightRows: [
                detail.user.name,
                age,
                detail.profile.birthDay,
                detail.profile.region,
                detail.profile.job,
                detail.profile.isPremium ? i10n.yes : i10n.not,
              ],
            ),
            _buildMoreInfomationCard(
              context: context,
              title: i10n.socialMedia,
              leftRows: [
                i10n.website,
                "twitter",
                "twitter_url",
                "pawoo_url",
              ],
              rightRows: [
                detail.profile.webpage ?? "",
                detail.profile.twitterAccount,
                detail.profile.twitterUrl ?? "",
                detail.profile.pawooUrl ?? "",
              ],
            ),
            _buildMoreInfomationCard(
              context: context,
              title: i10n.workspace,
              leftRows: [
                i10n.computer,
                i10n.monitor,
                i10n.softwareUsed,
                i10n.scanner,
                i10n.tablet,
                i10n.mouse,
                i10n.printer,
                i10n.onYourDesk,
                i10n.backgroundMusic,
                i10n.table,
                i10n.chair,
                i10n.other,
              ],
              rightRows: [
                detail.workspace.pc,
                detail.workspace.monitor,
                detail.workspace.tool,
                detail.workspace.scanner,
                detail.workspace.tablet,
                detail.workspace.mouse,
                detail.workspace.printer,
                detail.workspace.desktop,
                detail.workspace.music,
                detail.workspace.desk,
                detail.workspace.chair,
                detail.workspace.comment,
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 更多资料卡
  Widget _buildMoreInfomationCard({
    required BuildContext context,
    required String title,
    required List<String> leftRows,
    required List<String> rightRows,
  }) {
    var colorScheme = Theme.of(context).colorScheme;
    Color color = colorScheme.onSurface;
    TextStyle titleTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color);
    TextStyle leftTextStyle = TextStyle(fontSize: 14, color: color.withAlpha(200));
    TextStyle rightTextStyle = TextStyle(fontSize: 14, color: color);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(title, style: titleTextStyle),
        ),
        for (int i = 0; i < leftRows.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text(leftRows[i], style: leftTextStyle)),
                Expanded(flex: 2, child: Text(rightRows[i], style: rightTextStyle)),
              ],
            ),
          ),
      ]),
    );
  }
}
