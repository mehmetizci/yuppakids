import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yuppakids/repositories/repositories.dart';
import 'package:yuppakids/models/models.dart';
import 'package:yuppakids/blocs/search/blocs.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final YoutubeRepository youtubeRepository;

  SearchBloc({@required this.youtubeRepository})
      : assert(youtubeRepository != null),
        super(SearchInitial());

  Stream<SearchState> mapEventRequestedToState(SearchRequested event) async* {
    if (event is SearchRequested) {
      yield SearchLoadInProgress();
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

      yield SearchLoadSuccess(results: state.props + nextPageResults.results);
    } catch (_) {
      yield SearchLoadFailure();
    }
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchRequested) {
      yield* mapEventRequestedToState(event);
    } else if (event is FetchNextPage) {
      yield* mapFetchNextResultPage();
    }
  }
}
