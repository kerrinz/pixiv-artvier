import 'dart:io';

import 'package:artvier/base/base_page.dart';
import 'package:artvier/config/http_base_options.dart';
import 'package:artvier/pages/artwork/pixivision/model/pixivision_webview_page_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PixivisionWebViewPage extends BaseStatefulPage {
  /// 图片链接列表（每项含有多种画质链接）
  final PixivisionWebViewPageArguments arguments;

  const PixivisionWebViewPage(Object arg, {Key? key})
      : arguments = arg as PixivisionWebViewPageArguments,
        super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginWebState();
}

class _LoginWebState extends BasePageState<PixivisionWebViewPage> {
  @override
  void initState() {
    super.initState();
    // WebView使用Hybrid composition模式以避免安全键盘无法弹出的问题
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('使用网页登录'),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {},
        onWebViewCreated: (controller) {},
        initialUrl: "${HttpBaseOptions.pixivisionUrlHost}/${widget.arguments.language}/${widget.arguments.id}",
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith("pixiv://account/")) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
              name: "rnm",
              onMessageReceived: (JavascriptMessage message) {
                try {
                  // var value = json.decode(message.message);
                  // var id = value["_id"];
                  // var token = value["_token"];
                  // var cookie = value["_cookie"];
                  // AccountStorage.saveCurrentAccountProfile(account: new Account.create(userId: id, token: token, cookie: cookie));
                  // print(value["_id"]);
                } catch (e) {
                  //
                }
              }),
        },
      ),
    );
  }
}
