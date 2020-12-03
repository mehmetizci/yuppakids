import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:yuppakids/models/models.dart';
import 'dart:convert';

class YoutubeApiClient {
  static const baseUrl = 'http://localhost:3006';
  final http.Client httpClient;

  YoutubeApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<YoutubeSearchResult> searchVideo(String searchStr) async {
    final searchUrl =
        '$baseUrl/api/search?search_query=$searchStr' + '&sp=EgIQAQ%253D%253D';
    final searchResponse = await this.httpClient.get(searchUrl);
    if (searchResponse.statusCode != 200) {
      throw Exception('Error for getting search results');
    }

    final searchJson = jsonDecode(searchResponse.body);
    return YoutubeSearchResult.fromJson(searchJson);
  }
}
