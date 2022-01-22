import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/src/webview.dart';
import 'colors.dart' as color;

class covidPage extends StatefulWidget {
  const covidPage({Key? key}) : super(key: key);

  @override
  _covidPageState createState() => _covidPageState();
}

class _covidPageState extends State<covidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          WebView(
            initialUrl = "https://www.bing.com/covid/local/india",
          )



      )
      ));
  }
}
