import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:dicoding_news_app/utils/result_state.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({required this.apiService}) {
    fetchAllArticle();
  }

  late ArticlesResult _articlesResult;
  late ResultState _state;
  String _message = '';

  ArticlesResult get result => _articlesResult;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> fetchAllArticle() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final article = await apiService.topHeadLines();
      if (article.articles.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _articlesResult = article;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}
