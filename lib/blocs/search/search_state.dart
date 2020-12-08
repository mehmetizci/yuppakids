part of 'search_bloc.dart';

enum SearchStatus { initial, inprogress, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.results = const <Results>[],
    this.key = '',
    this.nextPageToken = '',
  });

  final SearchStatus status;
  final List<Results> results;
  final String key;
  final String nextPageToken;

  SearchState copyWith({
    SearchStatus status,
    List<Results> results,
    String key,
    String nextPageToken,
  }) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
      key: key ?? this.key,
      nextPageToken: nextPageToken ?? this.nextPageToken,
    );
  }

  @override
  List<Object> get props => [status, results, key, nextPageToken];
}
