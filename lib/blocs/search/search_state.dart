import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yuppakids/models/models.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadInProgress extends SearchState {}

class SearchLoadSuccess extends SearchState {
  final List<Results> results;

  const SearchLoadSuccess({@required this.results}) : assert(results != null);

  @override
  List<Object> get props => [results];
}

class SearchLoadFailure extends SearchState {}
