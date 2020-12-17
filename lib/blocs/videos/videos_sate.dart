import 'package:equatable/equatable.dart';
import 'package:yuppakids/repositories/repositories.dart';

abstract class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

class VideosLoading extends VideosState {}

class VideosLoaded extends VideosState {
  final List<Video> videos;

  const VideosLoaded([this.videos = const []]);

  @override
  List<Object> get props => [videos];

  @override
  String toString() => 'VideosLoaded { videos: $videos }';
}

class VideosNotLoaded extends VideosState {}
