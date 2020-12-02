import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:yuppakids/repositories/repositories.dart';
import 'package:yuppakids/models/models.dart';
import 'package:yuppakids/blocs/search/blocs.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final YoutubeRepository youtubeRepository;

  SearchBloc({@required this.youtubeRepository})
      : assert(youtubeRepository != null),
        super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchRequested) {
      yield SearchLoadInProgress();
      try {
        final YoutubeSearchResult searchResult =
            await youtubeRepository.getVideo(event.searchTerm);
        yield SearchLoadSuccess(results: searchResult.results);
      } catch (_) {
        yield SearchLoadFailure();
      }
    }
  }
}
