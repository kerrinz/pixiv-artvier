import 'package:flutter/material.dart';

/// 登录引导页面，未登录、添加帐号会跳转到这里
class LoginWizardPage extends StatelessWidget {
  const LoginWizardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: kToolbarHeight),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text("Pixgem", style: TextStyle(fontSize: 32)),
            ),
            const Text.rich(TextSpan(text: "（代理设置不对登录生效）")),
            Row(
              children: [
                Expanded(child: Container()),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed("setting_network"),
                  child: Row(
                    children: const [
                      Text("设置网络代理"),
                      Icon(Icons.arrow_right_rounded),
                    ],
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 20),
              elevation: 1.5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                side: BorderSide(width: 1, color: Colors.white12),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, "login_web"),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    "立即登录",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
