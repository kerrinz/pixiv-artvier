import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/store/global.dart';
import 'package:pixgem/store/network_store.dart';
import 'package:pixgem/widgets/badge.dart';
import 'package:pixgem/widgets/perference_single_choise_panel.dart';
import 'package:provider/provider.dart';

class SettingNetworkPage extends StatefulWidget {
  const SettingNetworkPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingNetworkPageState();
}

class SettingNetworkPageState extends State<SettingNetworkPage> {
  late TextEditingController _hostController;
  late TextEditingController _portController;
  late NetworkSettingProvider _provider;
  late int selectedindex; // 选择第几项

  @override
  void initState() {
    super.initState();
    _hostController = TextEditingController();
    _portController = TextEditingController();
    _provider = NetworkSettingProvider(
      NetworkStore.getProxyHost(),
      NetworkStore.getProxyPort(),
    );
    _hostController.text = NetworkStore.getProxyHost() ?? "";
    _portController.text = NetworkStore.getProxyPort() ?? "";
    selectedindex = (NetworkStore.getProxyEnable() ?? false) ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _provider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("代理和图片源"),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Container(
            padding: const EdgeInsets.all(8),
            // 这样解决了内容不足以支撑全屏时，滑动回弹不会回到原位的问题
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(builder: (context) {
                  return PerferenceSingleChoisePanel(
                    title: 'HTTP网络代理',
                    selectedindex: selectedindex,
                    onSelect: (index) {
                      selectedindex = index; // 选择了第几项
                      switch (index) {
                        case 0:
                          GlobalStore.proxy = null;
                          NetworkStore.setProxyEnable(false);
                          Fluttertoast.showToast(msg: "切换为系统代理", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                          break;
                        case 1:
                          GlobalStore.proxy = NetworkStore.getNetworkProxy();
                          NetworkStore.setProxyEnable(true);
                          Fluttertoast.showToast(msg: "切换为自定义代理", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                      }
                      (context as Element).markNeedsBuild();
                    },
                    widgets: <Widget>[
                      const Text(
                        "使用系统代理（默认）",
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          const Text("自定义代理", style: TextStyle(fontSize: 16)),
                          _buildProxyBadge(context),
                        ],
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 自定义代理的小徽章
  Widget _buildProxyBadge(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Badge(
        onTap: () {
          showDialog<bool>(
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("自定义代理"),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        autofocus: true,
                        controller: _hostController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "${CONSTANTS.proxy_default_host}（本机）",
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          isCollapsed: true, // 高度包裹，不会存在默认高度
                        ),
                      ),
                      TextField(
                        autofocus: false,
                        controller: _portController,
                        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                        decoration: const InputDecoration(
                          hintText: CONSTANTS.proxy_default_port,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          isCollapsed: true, // 高度包裹，不会存在默认高度
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("取消"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text("保存"),
                      onPressed: () async {
                        var host =
                            _hostController.text.isNotEmpty ? _hostController.text : CONSTANTS.proxy_default_host;
                        var port =
                            _portController.text.isNotEmpty ? _portController.text : CONSTANTS.proxy_default_port;
                        await NetworkStore.setNetworkProxy(host, port); // 持久化存储
                        GlobalStore.proxy = "$host:$port"; //
                        NetworkStore.setProxyEnable(true);
                        selectedindex = 1;
                        // 将选中状态返回
                        Navigator.of(context).pop();
                        setState(() {}); // 以后再优化
                      },
                    ),
                  ],
                );
              },
              context: context);
        },
        child: Row(
          children: [
            Text(
              NetworkStore.getNetworkProxy(),
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
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

class NetworkSettingProvider with ChangeNotifier {
  String? host;
  String? port;

  NetworkSettingProvider(this.host, this.port) : super();
}
