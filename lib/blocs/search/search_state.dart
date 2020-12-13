part of 'search_bloc.dart';

enum SearchStatus { initial, inprogress, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.results = const <Results>[],
    this.key = '',
    this.nextPageToken = '',
    this.error = '',
  });

  final SearchStatus status;
  final List<Results> results;
  final String key;
  final String nextPageToken;
  final String error;

  SearchState copyWith({
    SearchStatus status,
    List<Results> results,
    String key,
    String nextPageToken,
    String error,
  }) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
      key: key ?? this.key,
      nextPageToken: nextPageToken ?? this.nextPageToken,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, results, key, nextPageToken, error];
}
