import 'package:dicoding_news_app/provider/news_provider.dart';
import 'package:dicoding_news_app/utils/result_state.dart';
import 'package:dicoding_news_app/widget/card_article.dart';
import 'package:dicoding_news_app/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<NewsProvider>().fetchAllArticle();
      },
      child: Consumer<NewsProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
                itemCount: state.result.articles.length,
                itemBuilder: (context, index) {
                  var article = state.result.articles[index];
                  return CardArticle(article: article);
                });
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Material(child: Text('')),
            );
          }
        },
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }
}


// class ArticleListPage extends StatefulWidget {
//   const ArticleListPage({super.key});

//   @override
//   State<ArticleListPage> createState() => _ArticleListPageState();
// }

// class _ArticleListPageState extends State<ArticleListPage> {
//   late Future<ArticlesResult> _article;

//   @override
//   void initState() {
//     _article = ApiService().topHeadLines();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PlatformWidget(
//       androidBuilder: _buildAndroid,
//       iosBuilder: _buildIos,
//     );
//   }

//   Widget _buildList(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         await ApiService().topHeadLines();
//         setState(() {
//           _article = ApiService().topHeadLines();
//         });
//       },
//       child: FutureBuilder<ArticlesResult>(
//         future: _article,
//         builder: (context, snapshot) {
//           var state = snapshot.connectionState;
//           if (state != ConnectionState.done) {
//             return Platform.isIOS
//                 ? const Center(child: CupertinoActivityIndicator())
//                 : const Center(child: CircularProgressIndicator());
//           } else {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data?.articles.length,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   var article = snapshot.data?.articles[index];
//                   return CardArticle(article: article!);
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Material(child: Text(snapshot.error.toString())),
//               );
//             } else {
//               return const Material(child: Text(''));
//             }
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildAndroid(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('News App'),
//       ),
//       body: _buildList(context),
//     );
//   }

//   Widget _buildIos(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text('News App'),
//         transitionBetweenRoutes: false,
//       ),
//       child: _buildList(context),
//     );
//   }
// }
