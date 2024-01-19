import 'package:dicoding_news_app/common/navigation.dart';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:dicoding_news_app/ui/article_web_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article-detail';

  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: ListView(
        children: [
          Hero(
            tag: article.urlToImage!,
            child: Image.network(article.urlToImage!),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  article.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const Divider(color: Colors.grey),
                Text(article.description ?? ''),
                const Divider(
                  color: Colors.grey,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date: ${article.publishedAt}'),
                      Text('${article.author}')
                    ],
                  ),
                ),
                const Divider(color: Colors.grey),
                Text(
                  article.content ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                const Gap(10),
                ElevatedButton(
                  onPressed: () {
                    Navigation.intentWithData(
                        ArticleWebView.routeName, article.url);
                  },
                  child: const Text('Read More'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
