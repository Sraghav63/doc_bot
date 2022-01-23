import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'colors.dart' as color;

class medicalnewsresult_Page extends StatefulWidget {
  final String url;
  const medicalnewsresult_Page({Key? key, required this.url}) : super(key: key);

  @override
  _medicalnewsresult_PageState createState() => _medicalnewsresult_PageState();
}

class _medicalnewsresult_PageState extends State<medicalnewsresult_Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(

            child: Center(
                child: WebView(
                  initialUrl: widget.url,
                  onWebViewCreated: (WebViewController controller) {},
                  javascriptMode: JavascriptMode.unrestricted,
                ))
        )
    );
  }
}