import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/proxy/logic.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/proxy/proxy_settings.dart';
import 'package:artvier/pages/settings/develop/widgets/refresh_token_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginSettingsBottomSheet extends ConsumerStatefulWidget {
  final bool hideSomeSettings;

  const LoginSettingsBottomSheet({super.key, this.hideSomeSettings = true});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoginSettingsPageState();
}

class LoginSettingsPageState extends BasePageState<LoginSettingsBottomSheet> with ProxyLogic {
  late TextEditingController _hostController;
  late TextEditingController _portController;

  @override
  void initState() {
    super.initState();
    _hostController = TextEditingController();
    _portController = TextEditingController();
  }

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetSlideBar(),
          const Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: ProxySettings(),
          ),
          if (!widget.hideSomeSettings) const RefreshTokenSettings(),
        ],
      ),
    );
  }
}
