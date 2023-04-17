import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/component/perference/perference_single_choise_panel.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/global/provider/proxy_provider.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/proxy/logic.dart';

class ProxyOriginSettingsBottomSheet extends ConsumerStatefulWidget {
  const ProxyOriginSettingsBottomSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SettingNetworkPageState();
}

class SettingNetworkPageState extends ConsumerState<ProxyOriginSettingsBottomSheet> with ProxyLogic {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BottomSheetSlideBar(),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 24),
          child: Consumer(builder: (_, ref, __) {
            bool isEnabled = ref.watch(globalProxyStateProvider.select((value) => value.isProxyEnabled));
            return PerferenceSingleChoisePanel(
              title: 'HTTP网络代理',
              selectedindex: isEnabled ? 1 : 0,
              onSelect: (index) {
                switch (index) {
                  case 0:
                    handleProxyEnable(ref, proxyEnabled: false);
                    break;
                  case 1:
                    handleProxyEnable(ref, proxyEnabled: true);
                }
              },
              widgets: <Widget>[
                const Text(
                  "不使用代理（默认）",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    const Text("自定义代理", style: TextStyle(fontSize: 16)),
                    Expanded(child: _buildProxyBadge(context)),
                  ],
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  // 自定义代理的小徽章
  Widget _buildProxyBadge(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: MyBadge(
          onTap: () {
            _hostController.text = ref.read(inputProxyHostProvider) ?? "";
            _portController.text = ref.read(inputProxyPortProvider) ?? "";
            showDialog<bool>(
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("自定义代理"),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              const Expanded(flex: 1, child: Text("IP地址：")),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  autofocus: false,
                                  controller: _hostController,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.end,
                                  decoration: const InputDecoration(
                                    hintText: "${CONSTANTS.proxy_default_host}（本机）",
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                    isCollapsed: true, // 高度包裹，不会存在默认高度
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(child: Text("端口：")),
                              Expanded(
                                child: TextField(
                                  autofocus: false,
                                  controller: _portController,
                                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                                  textAlign: TextAlign.end,
                                  decoration: const InputDecoration(
                                    hintText: CONSTANTS.proxy_default_port,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                    isCollapsed: true, // 高度包裹，不会存在默认高度
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("取消"),
                        onPressed: () {
                          // 退回原来的值
                          ref.invalidate(inputProxyHostProvider);
                          ref.invalidate(inputProxyPortProvider);
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("保存"),
                        onPressed: () {
                          var host =
                              _hostController.text.isNotEmpty ? _hostController.text : CONSTANTS.proxy_default_host;
                          var port =
                              _portController.text.isNotEmpty ? _portController.text : CONSTANTS.proxy_default_port;
                          handleSaveProxyHostPort(ref, host: host, port: port)
                              .then((value) => Navigator.of(context).pop())
                              .catchError((_) => Fluttertoast.showToast(msg: "Save error"));
                        },
                      ),
                    ],
                  );
                },
                context: context);
          },
          child: Row(
            children: [
              Consumer(builder: (_, ref, __) {
                String? proxy = ref.watch(globalProxyStateProvider.select((value) => "${value.host}:${value.port}"));
                return Text(
                  proxy ?? "${CONSTANTS.proxy_default_host}:${CONSTANTS.proxy_default_port}",
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 12),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Icon(Icons.edit, size: 16, color: Theme.of(context).colorScheme.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
