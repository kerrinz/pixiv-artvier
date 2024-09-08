import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/perference/perference_single_choise_panel.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/global/provider/network_provider.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/proxy/logic.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProxySettings extends ConsumerStatefulWidget {
  const ProxySettings({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProxySettingsPageState();
}

class ProxySettingsPageState extends BasePageState<ProxySettings> with ProxyLogic {
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
    return Consumer(builder: (_, ref, __) {
      bool isEnabled = ref.watch(globalProxyStateProvider.select((value) => value.isProxyEnabled));
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PerferenceSingleChoisePanel(
            title: i10n.proxySettingsTitle,
            caption: i10n.proxySettingsTitleHint,
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
              Text(
                i10n.defaultNoProxy,
                style: textTheme.labelMedium,
              ),
              Row(
                children: [
                  Text(
                    i10n.customProxy,
                    style: textTheme.labelMedium,
                  ),
                  Expanded(child: _buildProxyBadge(context)),
                ],
              ),
            ],
          ),
          Builder(builder: (context) {
            // 未登录则隐藏直连功能
            bool hide = ref.watch(globalCurrentAccountProvider) == null;
            bool enable = ref.watch(globalDirectConnectionProvider);
            if (hide) {
              return const SizedBox();
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          i10n.enableDirectConnection,
                          style: textTheme.titleMedium,
                        ),
                        Text(
                          i10n.directConnectionHint,
                          style: textTheme.labelSmall?.copyWith(
                            color: textTheme.labelSmall?.color?.withOpacity(0.5),
                          ),
                        ),
                      ],
                    )),
                    Builder(builder: (context) {
                      return CupertinoSwitch(
                        value: enable,
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (value) async {
                          await ref.watch(globalDirectConnectionProvider.notifier).toggleDirect();
                          HttpHostOverrides().reload();
                        },
                      );
                    })
                  ],
                ),
              );
            }
          }),
        ],
      );
    });
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
                    title: Text(i10n.customProxy),
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
                  style: textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
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
