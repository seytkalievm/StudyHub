import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/color_codes.dart';
import 'ui_webview_controller.dart';
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
    Get.put<UIWebViewController>(UIWebViewController());

    return GetBuilder<UIWebViewController>(builder: (controller) {
      return Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: authorizationUrl.toString(),
            onPageStarted: (url) {
              controller.isLoading = true;
              controller.update();
            },
            navigationDelegate: (navReq) {
              if (navReq.url.startsWith(redirectUrl)) {
                var responseUrl = Uri.parse(navReq.url);
                Get.back(result: [responseUrl.queryParameters["code"]]);
              }

              return NavigationDecision.navigate;
            },
            onPageFinished: (url) {
              controller.isLoading = false;
              controller.update();
            },
          ),
          if (controller.isLoading)
            const CircularProgressIndicator(
              color: selectedTabColor,
            ),
        ],
      );
    });
  }
}
