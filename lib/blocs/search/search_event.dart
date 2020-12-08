part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchRequested extends SearchEvent {
  final String query;

  const SearchRequested({@required this.query}) : assert(query != null);

  @override
  List<Object> get props => [query];
}

class FetchNextPage extends SearchEvent {}

class ResetState extends SearchEvent {}
