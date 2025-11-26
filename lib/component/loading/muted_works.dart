import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// 作品已被屏蔽
class MutedWorks extends StatelessWidget {
  const MutedWorks({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SvgPicture.asset(
              'assets/icon/muted.svg',
              width: 48,
              height: 48,
              colorFilter: ColorFilter.mode(textTheme.bodySmall?.color ?? Colors.grey, BlendMode.srcIn),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(LocalizationIntl.of(context).workWasMuted, style: textTheme.titleMedium),
          ),
          TextButton(
              onPressed: () => Navigator.of(context).pushNamed(
                    RouteNames.mutedSettings.name,
                  ),
              child: Text(LocalizationIntl.of(context).mutedSettings)),
        ],
      ),
    );
  }
}
