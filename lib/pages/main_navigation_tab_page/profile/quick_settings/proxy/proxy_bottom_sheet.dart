import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/proxy/logic.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/proxy/proxy_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProxyOriginSettingsBottomSheet extends ConsumerStatefulWidget {
  const ProxyOriginSettingsBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SettingNetworkPageState();
}

class SettingNetworkPageState extends BasePageState<ProxyOriginSettingsBottomSheet> with ProxyLogic {
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomSheetSlideBar(),
        Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 24),
          child: ProxySettings(),
        ),
      ],
    );
  }
}
