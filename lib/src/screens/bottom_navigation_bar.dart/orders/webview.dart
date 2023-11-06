import 'package:flutter/material.dart';

class WebPage extends StatefulWidget {
  final String url;
  const WebPage({
    super.key,
    required this.url,
  });

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // WebView(
    //   initialUrl: widget.url,
    //   javascriptMode: JavascriptMode.unrestricted,
    // );
  }
}
