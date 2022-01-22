import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.only(top: 70, left: 15, right: 30),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.home),
            )
          ],
        ),
      ),
    );
  }
}
