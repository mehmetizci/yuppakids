import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:yuppakids/models/models.dart';
import 'dart:convert';

class YoutubeApiClient {
  static const baseUrl = 'http://192.168.1.26:3006';
  final http.Client httpClient;

  YoutubeApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<YoutubeSearchResult> searchVideo(
      {String searchStr, String key = '', String pageToken = ''}) async {
    final searchUrl = '$baseUrl/api/search?search_query=$searchStr' +
        (key.isNotEmpty && pageToken.isNotEmpty
            ? '&key=$key&pageToken=$pageToken'
            : '') +
        '&sp=CAASBBABIAE%253D';

    final urlEncoded = Uri.encodeFull(searchUrl);
    final searchResponse = await this.httpClient.get(urlEncoded);
    if (searchResponse.statusCode != 200) {
      throw Exception('Error for getting search results');
    }

    final searchJson = jsonDecode(searchResponse.body);
    return YoutubeSearchResult.fromJson(searchJson);
  }
}
