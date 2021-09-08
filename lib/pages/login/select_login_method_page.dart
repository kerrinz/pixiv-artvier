import 'package:flutter/material.dart';
import 'package:pixgem/pages/login/login_by_web_page.dart';

class SelectLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('选择登录方式'),
        backgroundColor: Colors.blueGrey,
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
              Navigator.of(context)
                  .pushNamed("setting_current_account");
              },
              child: Text("手动填写token登录"),
            ),
          ],
        )
      ),
    );
  }
}
