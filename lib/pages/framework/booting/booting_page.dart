import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/routes.dart';

/// app启动的加载过渡页面，载入一些数据
class BootingPage extends ConsumerStatefulWidget {
  const BootingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BootingPageState();
}

class BootingPageState extends ConsumerState<BootingPage> {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return Container(
      color: brightness == Brightness.light ? Colors.white : Colors.white10,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/icon/ic_launcher.png"),
            width: 128,
            height: 128,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: SizedBox(
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(strokeWidth: 2.0, color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        String? id = ref.read(globalCurrentAccountProvider)?.user.id;
        if (id == null) {
          // 拦截未登录
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(context, RouteNames.wizard.name, (route) => false);
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainNavigation.name, (route) => false);
        }
      }
    });
  }
}
