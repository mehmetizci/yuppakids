import 'dart:async';
import 'package:meta/meta.dart';
import 'package:yuppakids/repositories/youtube_api_client.dart';
import 'package:yuppakids/models/models.dart';

class YoutubeRepository {
  final YoutubeApiClient youtubeApiClient;
  String _lastSearchQuery;
  String _nextPageToken;
  String _key;

  YoutubeRepository({@required this.youtubeApiClient})
      : assert(youtubeApiClient != null);

  Future<YoutubeSearchResult> getVideo(String query) async {
    final searchResult = await youtubeApiClient.searchVideo(query: query);
    return searchResult;
  }

  Future<YoutubeSearchResult> fetchNextResultPage() async {
    if (_lastSearchQuery == null) {
      throw SearchNotInitiatedException();
    }

    if (_nextPageToken == null) {
      throw NoNextPageTokenException();
    }

    final nextPageSearchResult = await youtubeApiClient.searchVideo(
        query: _lastSearchQuery, key: _key, pageToken: _nextPageToken);

    _cacheValues(
        query: _lastSearchQuery,
        nextPageToken: nextPageSearchResult.nextPageToken,
        key: nextPageSearchResult.key);
    return nextPageSearchResult;
  }

  void _cacheValues({String query, String key, String nextPageToken}) {
    _lastSearchQuery = query;
    _nextPageToken = nextPageToken;
    _key = key;
  }
}

class NoNextPageTokenException implements Exception {}

class NoSearchResultsException implements Exception {
  final message = 'No results';
}

class SearchNotInitiatedException implements Exception {
  final message = 'Cannot get the next result page without searching first.';
}
