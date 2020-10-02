import 'package:Newsflix/helper/news.dart';
import 'package:Newsflix/models/article_model.dart';
import 'package:Newsflix/tile/blogTile.dart';
import 'package:flutter/material.dart';

class SearchNews extends StatefulWidget {
  final String searchword;
  SearchNews({this.searchword});
  @override
  _SearchNewsState createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  List<ArticleModel> articles = new List<ArticleModel>();
  // ignore: unused_field
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getSearchNews();
  }

  getSearchNews() async {
    SearchNewsClass newsClass = SearchNewsClass();
    await newsClass.getNews(widget.searchword);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              // Blogs
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
