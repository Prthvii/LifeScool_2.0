import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebPagePlain extends StatefulWidget {
  final String url;
  final String type;

  WebPagePlain({Key key, this.url, this.type}) : super(key: key);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebPagePlain> {
  String title, url;
  bool isLoading = true;
  final _key = UniqueKey();
  InAppWebViewController _webViewController;

  WebViewState(String title, String url) {
    this.title = title;
    this.url = url;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
      body: Stack(
        children: <Widget>[
          InAppWebView(

              initialUrlRequest:
                  URLRequest(url: Uri.parse(widget.url.toString())),
              //  initialUrlRequest: "https://appr.tc/r/158489234",
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  mediaPlaybackRequiresUserGesture: false,
                  // debuggingEnabled: true,
                ),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
              },
              onLoadStop: (controller, url) {
                setState(() {
                  isLoading = false;
                });
              },
              androidOnPermissionRequest: (InAppWebViewController controller,
                  String origin, List<String> resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              }),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
