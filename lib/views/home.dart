import 'package:Newsflix/helper/datasource.dart';
import 'package:Newsflix/helper/news.dart';
import 'package:Newsflix/models/article_model.dart';
import 'package:Newsflix/models/category_model.dart';
import 'package:Newsflix/tile/blogTile.dart';
import 'package:Newsflix/tile/categoryTile.dart';
import 'package:Newsflix/views/search.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
      print('Page reloaded!');
    });
  }

  Future fetchdata() async {
    _loading = true;
    getNews();
  }

  @override
  void initState() {
    categories = getCategories();
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String temp;
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                }),
            IconButton(
                icon: Icon(Theme.of(context).brightness == Brightness.light
                    ? Icons.highlight
                    : Icons.lightbulb_outline),
                onPressed: () {
                  DynamicTheme.of(context).setBrightness(
                      Theme.of(context).brightness == Brightness.light
                          ? Brightness.dark
                          : Brightness.light);
                })
          ],
          title: Row(
            children: <Widget>[
              Text("News",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              Text("Flix",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.red)),
            ],
          ),
          elevation: 0.0,
        ),
        body: _loading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : RefreshIndicator(
                onRefresh: fetchdata,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        // Categories
                        Container(
                          height: 70,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return CategoryTile(
                                  imageUrl: categories[index].imageUrl,
                                  categoryName: categories[index].categoryName,
                                );
                              }),
                        ),
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
              ));
  }
}
