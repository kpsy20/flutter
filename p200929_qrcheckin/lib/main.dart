import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_coupang_ad/flutter_coupang_ad.dart';

void main() => runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: WebViewExample()));

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  AdmobBannerSize bannerSize;

  @override
  void initState() {
    Admob.requestTrackingAuthorization();
    Admob.initialize(); 
    bannerSize = AdmobBannerSize.BANNER;
 
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Builder(
                builder: (BuildContext context) {
                  return WebView(
                    initialUrl: 'https://nid.naver.com/login/privacyQR',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                  );
                },
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: CoupangAdView(
                      CoupangAdConfig(adId: '332365', height: 100)))
            ],
          ),
        ),
      ),
    );
  }
}
