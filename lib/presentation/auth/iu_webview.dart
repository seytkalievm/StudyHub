import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UIWebView extends StatelessWidget {
  final String authorizationUrl;
  final String redirectUrl;

  const UIWebView({
    Key? key,
    required this.authorizationUrl,
    required this.redirectUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: authorizationUrl.toString(),
      navigationDelegate: (navReq) {
        if (navReq.url.startsWith(redirectUrl)) {
          var responseUrl = Uri.parse(navReq.url);
          Get.back(result: [responseUrl.queryParameters["code"]]);
        }
        Get.back();

        return NavigationDecision.navigate;
      },
    );
  }
}
