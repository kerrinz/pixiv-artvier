import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebPage extends BaseStatefulPage {
  const LoginWebPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginWebState();
}

class _LoginWebState extends BasePageState<LoginWebPage> {
  final WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    String url = ref.read(globalCurrentAccountProvider.notifier).getLoginWebViewUrl();
    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(NavigationDelegate(onNavigationRequest: (NavigationRequest request) async {
        if (request.url.startsWith("pixiv://account/")) {
          // 拦截，拿到code
          String? code = Uri.parse(request.url).queryParameters["code"];
          if (code != null) {
            // OAuth登录
            ref.read(globalCurrentAccountProvider.notifier).oAuthLogin(code).then((value) {
              Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainNavigation.name, (route) => false);
            }).catchError((onError) {
              // TODO: 待处理登录失败的逻辑
            });
          } else {
            //
          }
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('使用网页登录'),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
