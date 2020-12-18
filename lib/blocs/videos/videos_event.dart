part of 'videos_bloc.dart';
abstract class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object> get props => [];
}

class LoadVideos extends VideosEvent {}

class AddVideo extends VideosEvent {
  final Video video;

  const AddVideo(this.video);

  @override
  List<Object> get props => [video];

  @override
  String toString() => 'AddVideo { video: $video }';
}

class UpdateVideo extends VideosEvent {
  final Video updatedVideo;

  const UpdateVideo(this.updatedVideo);

  @override
  List<Object> get props => [updatedVideo];

  @override
  String toString() => 'UpdateVideo { updatedVideo: $updatedVideo }';
}

class DeleteVideo extends VideosEvent {
  final Video video;

  const DeleteVideo(this.video);

  @override
  List<Object> get props => [video];

  @override
  String toString() => 'DeleteVideo { video: $video }';
}

class ClearCompleted extends VideosEvent {}

class ToggleAll extends VideosEvent {}

class VideosUpdated extends VideosEvent {
  final List<Video> videos;

  const VideosUpdated(this.videos);

  @override
  List<Object> get props => [videos];
}
