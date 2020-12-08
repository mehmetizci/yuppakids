import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yuppakids/repositories/repositories.dart';
import 'package:yuppakids/models/models.dart';
//import 'package:yuppakids/blocs/search/blocs.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final YoutubeRepository youtubeRepository;

  SearchBloc({@required this.youtubeRepository})
      : assert(youtubeRepository != null),
        super(SearchState());

  Feature<SearchState> mapEventRequestedToState(SearchState state) async {
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
  }

  Stream<SearchState> mapFetchNextResultPage() async* {
    try {
      final nextPageResults = await youtubeRepository.fetchNextResultPage();

      yield SearchLoadSuccess(
          results: state.copyWith(results) + nextPageResults.results);
    } catch (_) {
      yield SearchLoadFailure();
    }
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchRequested) {
      yield* mapEventRequestedToState(state);
    } else if (event is FetchNextPage) {
      yield* mapFetchNextResultPage();
    }
  }
}
