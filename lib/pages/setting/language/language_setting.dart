import 'package:flutter/material.dart';
import 'package:pixgem/component/perference/perference_single_choise_panel.dart';
import 'package:pixgem/store/global.dart';
import 'package:provider/provider.dart';

class LanguageSettingPage extends StatefulWidget {
  const LanguageSettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LanguageSettingPageState();
}

class LanguageSettingPageState<LanguageSettingPage> extends State {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GlobalStore.globalProvider,
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
                    title: 'App语言 / Language',
                    selectedindex: 0,
                    onSelect: (index) {
                      (context as Element).markNeedsBuild();
                    },
                    widgets: <Widget> [
                      Text(
                        "跟随系统（默认）",
                        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Text(
                        "简体中文",
                        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Text(
                        "English(US)",
                        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
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
}
