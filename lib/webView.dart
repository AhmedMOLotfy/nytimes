import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebV extends StatefulWidget {
  final String url;
  WebV({this.url});
  @override
  _WebVState createState() => _WebVState();
}

class _WebVState extends State<WebV> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState() {
    // if (Platform.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "New York Times",
          style: TextStyle(
            color: Colors.white,
            fontSize: 29,
            fontFamily: 'UnifrakturCook',
          ),
        ),
      ),
      body: WebView(
          initialUrl: '${widget.url}',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          }),
    );
  }
}
