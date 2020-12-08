part of 'search_bloc.dart';

enum SearchStatus { initial, inprogress, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.results = const <Results>[],
    this.hasReachedMax = false,
  });

  final SearchStatus status;
  final List<Results> results;
  final bool hasReachedMax;

  SearchState copyWith({
    SearchStatus status,
    List<Results> results,
    bool hasReachedMax,
  }) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, results, hasReachedMax];
}
