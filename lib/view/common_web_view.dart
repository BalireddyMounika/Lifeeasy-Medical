import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../common_widgets/common_appbar.dart';


class CommonWebView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommonWebView();

  String url, title;
  CommonWebView(this.url, this.title);
}

class _CommonWebView extends State<CommonWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            Text('loading...');
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},

        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBar(
          title: widget.title,
          onClearPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.dashboardView, (route) => false);
          },
          onBackPressed: () {
            Navigator.pop(context);
          },
        ),
        body: WebViewWidget(controller: controller),

      ),
    );
  }
}
