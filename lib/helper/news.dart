import 'dart:convert';

import 'package:Newsflix/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  getNews() async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=in&pageSize=30&apiKey=d2f84c4193594448ba331ed892a6a536';

    http.Response response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']);

          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  getNews(String category) async {
    String url =
        'http://newsapi.org/v2/top-headlines?category=$category&country=in&pageSize=30&apiKey=d2f84c4193594448ba331ed892a6a536';

    http.Response response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']);

          news.add(articleModel);
        }
      });
    }
  }
}

// Getsearchnews

class SearchNewsClass {
  List<ArticleModel> news = [];

  getNews(String searchquery) async {
    String url =
        'https://newsapi.org/v2/everything?q=$searchquery&sortBy=popularity,relavance,pubhlishedAt&language=en&apiKey=d2f84c4193594448ba331ed892a6a536';

    http.Response response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']);

          news.add(articleModel);
        }
      });
    }
  }
}
