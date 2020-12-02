import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchRequested extends SearchEvent {
  final String searchTerm;

  const SearchRequested({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => [searchTerm];
}
