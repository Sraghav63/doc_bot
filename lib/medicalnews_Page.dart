import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'colors.dart' as color;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'medicalnewsresult_Page.dart';

class medicalnewsPage extends StatefulWidget {
  const medicalnewsPage({Key? key}) : super(key: key);

  @override
  _medicalnewsPageState createState() => _medicalnewsPageState();
}

class _medicalnewsPageState extends State<medicalnewsPage> {

  late Future<Articles> data;
  final api_url = 'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=034967142831487693e9b0eeba807207';
  final List<String> items = List<String>.generate(10000, (i) => 'Item $i');

  @override
  void initState() {
    super.initState();
    data = fetchMedicalnews();
  }

  Future<Articles> fetchMedicalnews() async {
    final response = await http.get(Uri.parse(api_url));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Articles.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

  }

  @override
  Widget build(BuildContext context) {


    const title = "Medical News";


    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(title),
          ),
          body: Center(
            child: FutureBuilder<Articles>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 19,
                    itemBuilder: (ctx, index) {
                      print('debug1');

                      String list_title = snapshot.data!.articles[index].title;
                      if (list_title.length > 30) {
                        list_title = list_title.substring(0,30) + '...';
                      }

                      String list_desc = snapshot.data!.articles[index].description;

                      if (list_desc.length > 30) {
                        list_desc = list_desc.substring(0,30) + '...';
                      }
                      print('debug2');
                      return ListTile(
                        title: Text(
                          list_title,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(list_desc),
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 64,
                            maxHeight: 64,
                          ),
                          child: Image.network(snapshot.data!.articles[index].urlToImage, fit: BoxFit.cover),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => medicalnewsresult_Page(url: snapshot.data!.articles[index].url),
                            ),
                          );
                        },
                      );
                    },
                  );
                  // return Text(snapshot.data!.totalResults.toString());
                } else if (snapshot.hasError) {
                  return Text('error: ${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          )
      ),
    );
  }

// ListTile newsreport(ctx, index) {
//   return ListTile(
//     title: Text(
//       data.articles[index],
//       style: TextStyle(fontWeight: FontWeight.w500),
//     ),
//     subtitle: const Text('My City, CA 99984'),
//     leading: ConstrainedBox(
//       constraints: BoxConstraints(
//         minWidth: 44,
//         minHeight: 44,
//         maxWidth: 64,
//         maxHeight: 64,
//       ),
//       child: Image.network('https://static.toiimg.com/photo/89053418.cms', fit: BoxFit.cover),
//     ),
//   );
// }

}


class Article {

  final String title;
  final String description;
  final String url;
  final String urlToImage;


  const Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,

  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(

      title: json['title'] ?? "",
      description: json['description'] ?? "",
      urlToImage: json['urlToImage'] ?? "data:image/png;base64,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",
      url: json['url'],


    );
  }
}

class Articles {
  final int totalResults;
  final List<Article> articles;

  const Articles({
    required this.totalResults,
    required this.articles
  });

  factory Articles.fromJson(Map<String, dynamic> json) {

    var num = json['articles'].length;
    List<Article> arts = [];
    for (var i = 0; i < num; i++){
      arts.add(Article.fromJson(json['articles'][i]));
    }

    return Articles(

        totalResults: json['totalResults'],
        articles: arts
    );
  }
}
