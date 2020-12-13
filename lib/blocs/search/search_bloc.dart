import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yuppakids/repositories/repositories.dart';
import 'package:yuppakids/models/models.dart';
//import 'package:yuppakids/blocs/search/blocs.dart';
import 'dart:async';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final YoutubeRepository youtubeRepository;

  SearchBloc({@required this.youtubeRepository})
      : assert(youtubeRepository != null),
        super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchRequested) {
      yield* mapSearchRequested(event);
    } else if (event is FetchNextPage) {
      yield* mapFetchNextResultPage();
    } else if (event is ResetState) {
      yield* mapResetState();
    }
  }

  Stream<SearchState> mapResetState() async* {
    yield state.copyWith(
      status: SearchStatus.initial,
      results: [],
      key: '',
      nextPageToken: '',
      error: '',
    );
  }

  Stream<SearchState> mapFetchNextResultPage() async* {
    try {
      final nextPageResults = await youtubeRepository.fetchNextResultPage();

      yield state.copyWith(
        status: SearchStatus.success,
        results: List.of(state.results)..addAll(nextPageResults.results),
        key: nextPageResults.key,
        nextPageToken: nextPageResults.nextPageToken,
      );
    } catch (_) {
      yield state.copyWith(
          status: SearchStatus.failure, error: _.error.toString());
    }
  }

  Stream<SearchState> mapSearchRequested(SearchRequested event) async* {
    if (state.status == SearchStatus.initial) {
      yield state.copyWith(status: SearchStatus.inprogress);
      try {
        final YoutubeSearchResult searchResult =
            await youtubeRepository.getVideo(event.query);

        yield state.copyWith(
          status: SearchStatus.success,
          results: searchResult.results,
          key: searchResult.key,
          nextPageToken: searchResult.nextPageToken,
        );
      } catch (_) {
        yield state.copyWith(
            status: SearchStatus.failure, error: _.error.toString());
      }
    }
  }

  /*Stream<SearchState> mapEventRequestedToState(SearchState state) async* {
    if (state.hasReachedMax) return state;
    if (state.status == SearchStatus.initial) {
      yield SearchStatus.inprogress;
      try {
        final YoutubeSearchResult searchResult =
            await youtubeRepository.getVideo(event.query);
        yield SearchLoadSuccess(results: searchResult.results);
      } catch (_) {
        yield SearchLoadFailure();
      }
    }
  }*/
}
