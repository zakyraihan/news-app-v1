import 'package:dicoding_news_app/data/db/database_helper.dart';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:dicoding_news_app/utils/result_state.dart';
import 'package:flutter/foundation.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getBookmarks();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Article> _bookmarks = [];
  List<Article> get bookmarks => _bookmarks;

  void _getBookmarks() async {
    _bookmarks = await databaseHelper.getBookMarks();

    if (_bookmarks.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'empty data';
    }
    notifyListeners();
  }

  void addBookMark(Article article) async {
    try {
      await databaseHelper.insertBookMark(article);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error -> $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String url) async {
    final bookmarkedArticle = await databaseHelper.getBookMarkByUrl(url);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeBookmark(String url) async {
    try {
      await databaseHelper.removeBookmark(url);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error -> $e';
      notifyListeners();
    }
  }
}
