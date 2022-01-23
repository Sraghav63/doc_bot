import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:http/http.dart';

class question extends StatefulWidget {
  const question({Key? key}) : super(key: key);

  @override
  _questionState createState() => _questionState();
}

class _questionState extends State<question> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 15, right: 30),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Enter your question here",
                labelText: "Enter your question here",
              ),
              controller: textController1,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  final String aidocURL = "aidoc.loca.lt";
                  print("trying to get answer to question: ");
                  print(textController1.text.trim());
                  var queryParameters = {
                    "question": textController1.text.trim()
                  };
                  var uri = Uri.https(aidocURL, "/medicaladvice", queryParameters);
                  Response res = await get(uri, headers: {
                    HttpHeaders.contentTypeHeader: "application/json"
                  });
                  if (res.statusCode == 200) {
                    String answer = (res.body);
                    print("answer is: ");
                    print(answer);
                    textController2.text = answer;
                  } else {
                    //TODO: report error
                    print("error getting response from aidoc");
                  }
                },
                child: Text("Enter")),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: textController2,
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}