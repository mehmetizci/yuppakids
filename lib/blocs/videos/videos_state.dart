part of 'videos_bloc.dart';

enum VideosStatus { initial, inprogress, success, failure }

class VideosState extends Equatable {
  const VideosState({
    this.status = VideosStatus.initial,
    this.videos = const <Object>[],
    this.error = '',
  });

  final VideosStatus status;
  final List<Object> videos;
  final String error;

  VideosState copyWith({
    VideosStatus status,
    List<Object> videos,
    String error,
  }) {
    return VideosState(
      status: status ?? this.status,
      videos: videos ?? this.videos,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, videos, error];
}
