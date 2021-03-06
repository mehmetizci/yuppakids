import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:yuppakids/models/youtube/models.dart';
import 'dart:convert';

class YoutubeApiClient {
  static const baseUrl = 'https://yuppakidsapi.oa.r.appspot.com';
  final http.Client httpClient;

  YoutubeApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<YoutubeSearchResult> searchVideo(
      {String query, String key = '', String pageToken = ''}) async {
    final searchUrl = '$baseUrl/api/search?search_query=$query' +
        (key.isNotEmpty && pageToken.isNotEmpty
            ? '&key=$key&pageToken=$pageToken'
            : '') +
        '&sp=EgIQAQ%253D%253D';
    print(searchUrl);
    // final urlEncoded = Uri.encodeFull(searchUrl);
    final searchResponse = await this.httpClient.get(searchUrl);
    if (searchResponse.statusCode != 200) {
      throw Exception('Error for getting search results');
    }

    final searchJson = jsonDecode(searchResponse.body);
    return YoutubeSearchResult.fromJson(searchJson);
  }
}
