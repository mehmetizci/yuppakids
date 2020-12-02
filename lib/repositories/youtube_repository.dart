import 'dart:async';
import 'package:meta/meta.dart';
import 'package:yuppakids/repositories/youtube_api_client.dart';
import 'package:yuppakids/models/models.dart';

class YoutubeRepository {
  final YoutubeApiClient youtubeApiClient;

  YoutubeRepository({@required this.youtubeApiClient})
      : assert(youtubeApiClient != null);

  Future<YoutubeSearchResult> getVideo(String searchTerm) async {
    final searchResult = await youtubeApiClient.searchVideo(searchTerm);
    return searchResult;
  }
}
