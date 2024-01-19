import 'dart:convert';

import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '0c4926a618b24ad9b683318005c50ad4';
  static const String _category = 'business';
  static const String _country = 'us';

  Future<ArticlesResult> topHeadLines() async {
    final response = await http.get(Uri.parse(
        '${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed To Load Top Headlines');
    }
  }
}
