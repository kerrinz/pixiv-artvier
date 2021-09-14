import 'package:flutter/material.dart';
import 'package:pixgem/pages/login/login_by_web_page.dart';

/// 登录引导页面，未登录、添加帐号会跳转到这里
class LoginWizardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('选择登录方式'),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginWebPage();
                  }));
                },
                child: Text("使用网页登录"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("setting_current_account");
                },
                child: Text("手动填写token登录"),
              ),
            ],
          )),
    );
  }
}
