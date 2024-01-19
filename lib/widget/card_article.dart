import 'package:dicoding_news_app/common/navigation.dart';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:dicoding_news_app/provider/database_provider.dart';
import 'package:dicoding_news_app/ui/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(article.url),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(article.title),
              subtitle: Text(article.author ?? ''),
              leading: Hero(
                tag: article.urlToImage!,
                child: Image.network(article.urlToImage!),
              ),
              onTap: () {
                Navigation.intentWithData(ArticleDetailPage.routeName, article);
              },
              trailing: isBookmarked
                  ? IconButton(
                      icon: const Icon(Icons.bookmark),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () => provider.removeBookmark(article.url),
                    )
                  : IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () => provider.addBookMark(article),
                    ),
            );
          },
        );
      },
    );
  }
}
