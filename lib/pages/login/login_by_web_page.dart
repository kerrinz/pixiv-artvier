import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/request/oauth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginWebState();
  }
}

class _LoginWebState extends State {
  late WebViewController _controller;
  String codeChallenge = "";

  @override
  void initState() {
    super.initState();
    // WebView使用Hybrid composition模式以避免安全键盘无法弹出的问题
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('使用网页登录'),
        backgroundColor: Colors.blueGrey,
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {
        },
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        initialUrl: OAuth.getLoginWebViewUrl(),
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith("pixiv://account/")) {
            // 拦截，拿到code
            String? code = Uri.parse(request.url).queryParameters["code"];
            if (code != null) {
              // OAuth登录
              oAuthLogin(code).then((value) {
                print("Login success!");
                Navigator.pushNamedAndRemoveUntil(
                    context, "main", (route) => route == null);
              }).catchError((onError) {
                print(onError);
                // 待处理登录失败的逻辑
              });
            } else print("code=null");
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        javascriptChannels: <JavascriptChannel>[
          JavascriptChannel(
              name: "rnm",
              onMessageReceived: (JavascriptMessage message) {
                print(message.message);
                try {
                  var value = json.decode(message.message);
                  var id = value["_id"];
                  var token = value["_token"];
                  var cookie = value["_cookie"];
                  // AccountStore.saveCurrentAccountProfile(account: new Account.create(userId: id, token: token, cookie: cookie));
                  // print(value["_id"]);
                } catch (e) {
                  print("????????????? Error javascriptChannels");
                  print(e);
                }
              }),
        ].toSet(),
      ),
    );
  }

  // OAuth2.1登录方式
  Future oAuthLogin(code) async {
    // 请求用户数据（含token）
    AccountProfile profile = await OAuth().requestToken(code: code);

    // 刷新一次token
    var newProfile = await OAuth().refreshToken(profile.refreshToken);
    // 保存新配置
    await OAuth().saveTokenToCurrent(newProfile);
  }
}
