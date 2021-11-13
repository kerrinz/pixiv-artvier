import 'package:flutter/material.dart';
import 'store/account_store.dart';
import 'store/global.dart';

/// app启动的加载过渡页面，在这里会加载一些全局数据
///
class BootingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BootingPageState();
}

class BootingPageState extends State<BootingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).bottomAppBarColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pixgem",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: SizedBox(
                width: 32.0,
                height: 32.0,
                child: CircularProgressIndicator(strokeWidth: 2.0, color: Theme.of(context).accentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initAppData().catchError((onError) => Navigator.of(context).pushNamed("login_wizard"));
  }

  // 初始化全局数据，拦截未登录
  Future initAppData() async {
    await GlobalStore.init(); // 初始化一些全局数据
    String? id = await AccountStore.getCurrentAccountId();
    if (id != null) {
      // 已登录
      Navigator.pushNamedAndRemoveUntil(
          context, "main", (route) => false);
    } else {
      // 未登录
      Navigator.pushNamedAndRemoveUntil(
          context, "login_wizard", (route) => false);
    }
  }
}
