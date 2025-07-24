import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/perference/perference_single_choise_panel.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/config/http_base_options.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/global/provider/network_provider.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/proxy/logic.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late TextEditingController _imageHostController;

  @override
  void initState() {
    super.initState();
    _hostController = TextEditingController();
    _portController = TextEditingController();
    _imageHostController = TextEditingController();
  }

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _imageHostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HTTP Proxy
        Builder(builder: (context) {
          bool isEnabled = ref.watch(globalProxyStateProvider.select((value) => value.isProxyEnabled));
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: PerferenceSingleChoisePanel(
              title: l10n.proxySettingsTitle,
              caption: l10n.proxySettingsTitleHint,
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
                  l10n.defaultNoProxy,
                  style: textTheme.labelMedium,
                ),
                Row(
                  children: [
                    Text(
                      l10n.customProxy,
                      style: textTheme.labelMedium,
                    ),
                    Expanded(child: _buildProxyBadge(context)),
                  ],
                ),
              ],
            ),
          );
        }),
        // Custom image hosting
        Builder(builder: (context) {
          bool hide = ref.watch(globalCurrentAccountProvider) == null;
          final state = ref.watch(globalImageHostingProvider);
          if (hide) {
            return const SizedBox();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.customImageHosting,
                            style: textTheme.titleMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: _imageHostBadge(context),
                          )
                        ],
                      )),
                      Builder(builder: (context) {
                        return CupertinoSwitch(
                          value: state.isEnabled,
                          activeTrackColor: Theme.of(context).colorScheme.primary,
                          onChanged: (value) async {
                            if (Theme.of(context).platform == TargetPlatform.android) {
                              HapticFeedback.lightImpact();
                            }
                            await ref.read(globalImageHostingProvider.notifier).toggle();
                          },
                        );
                      })
                    ],
                  ),
                ],
              ),
            );
          }
        }),
        // Direct connection
        Builder(builder: (context) {
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
                        l10n.enableDirectConnection,
                        style: textTheme.titleMedium,
                      ),
                      Text(
                        l10n.directConnectionHint,
                        style: textTheme.labelSmall?.copyWith(
                          color: textTheme.labelSmall?.color?.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  )),
                  Builder(builder: (context) {
                    return CupertinoSwitch(
                      value: enable,
                      activeTrackColor: Theme.of(context).colorScheme.primary,
                      onChanged: (value) async {
                        if (Theme.of(context).platform == TargetPlatform.android) {
                          HapticFeedback.lightImpact();
                        }
                        await ref.read(globalDirectConnectionProvider.notifier).toggleDirect();
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
                    title: Text(l10n.customProxy),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(flex: 1, child: Text(l10n.ipAdressEditing)),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  autofocus: false,
                                  controller: _hostController,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.end,
                                  decoration: const InputDecoration(
                                    hintText: CONSTANTS.proxy_default_host,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                    isCollapsed: true, // 高度包裹，不会存在默认高度
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex: 1, child: Text(l10n.portEditing)),
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
                        child: Text(l10n.promptCancel),
                        onPressed: () {
                          // 退回原来的值
                          ref.invalidate(inputProxyHostProvider);
                          ref.invalidate(inputProxyPortProvider);
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(l10n.promptConform),
                        onPressed: () {
                          var host =
                              _hostController.text.isNotEmpty ? _hostController.text : CONSTANTS.proxy_default_host;
                          var port =
                              _portController.text.isNotEmpty ? _portController.text : CONSTANTS.proxy_default_port;
                          handleSaveProxyHostPort(ref, host: host, port: port).then((value) {
                            if (context.mounted) Navigator.of(context).pop();
                          }).catchError((_) {
                            Fluttertoast.showToast(msg: "Save error");
                          });
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

  // 自定义图片源的小徽章
  Widget _imageHostBadge(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: MyBadge(
        onTap: () {
          _imageHostController.text = ref.read(inputImageHostProvider) ?? "";
          showDialog<bool>(
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(l10n.editImageHosting),
                  content: SingleChildScrollView(
                    child: TextField(
                      autofocus: false,
                      controller: _imageHostController,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintText: HttpBaseOptions.pximgHost,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        isCollapsed: true, // 高度包裹，不会存在默认高度
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(l10n.promptCancel),
                      onPressed: () {
                        // 退回原来的值
                        ref.invalidate(inputImageHostProvider);
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(l10n.promptConform),
                      onPressed: () {
                        var host = _imageHostController.text.isNotEmpty
                            ? _imageHostController.text
                            : HttpBaseOptions.pximgHost;
                        handleSaveImageHost(ref, host: host).then((value) {
                          if (context.mounted) Navigator.of(context).pop();
                        }).catchError((_) {
                          Fluttertoast.showToast(msg: "Save error");
                        });
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
              String? proxy = ref.watch(globalImageHostingProvider.select((value) => value.host));
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
    );
  }
}
