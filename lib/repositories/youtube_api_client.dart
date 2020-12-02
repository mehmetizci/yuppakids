import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:yuppakids/models/models.dart';
import 'dart:convert';

class YoutubeApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  YoutubeApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<YoutubeSearchResult> searchVideo(String searchStr) async {
    final searchUrl = '$baseUrl/api/location/search/?query=$searchStr';
    final searchResponse = await this.httpClient.get(searchUrl);
    if (searchResponse.statusCode != 200) {
      throw Exception('Error for getting search results');
    }

    final searchJson = jsonDecode(searchResponse.body);
    return YoutubeSearchResult.fromJson(searchJson);
  }
}
