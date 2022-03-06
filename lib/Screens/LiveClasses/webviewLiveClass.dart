import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLive extends StatefulWidget {
  final String url;
  final String type;

  WebViewLive({Key key, this.url,this.type}) : super(key: key);

  @override
  WebViewState createState() => WebViewState();
}
class WebViewState extends State<WebViewLive>{


  bool isLoading=true;
  final _key = UniqueKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[

          SizedBox(height: 100,),
          WebView(
            key: _key,
            initialUrl: widget.type=="MIPDF"?'https://docs.google.com/gview?embedded=true&url=${widget.url}': widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? Center( child: CircularProgressIndicator(),)
              : Stack(),
        ],
      ),
    );
  }

}

