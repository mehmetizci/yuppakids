import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yuppakids/repositories/repositories.dart';
import 'dart:async';

part 'videos_state.dart';
part 'videos_event.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final VideosRepository _videosRepository;
  StreamSubscription _videosSubscription;

  VideosBloc({@required VideosRepository videosRepository})
      : assert(videosRepository != null),
        _videosRepository = videosRepository,
        super(VideosState());

  @override
  Stream<VideosState> mapEventToState(VideosEvent event) async* {
    if (event is LoadVideos) {
      yield* _mapLoadVideosToState();
    } else if (event is AddVideo) {
      yield* _mapAddVideoToState(event);
    } else if (event is UpdateVideo) {
      yield* _mapUpdateVideoToState(event);
    } else if (event is DeleteVideo) {
      yield* _mapDeleteVideoToState(event);
    } else if (event is ToggleAll) {
      // yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      // yield* _mapClearCompletedToState();
    } else if (event is VideosUpdated) {
      yield* _mapVideosUpdateToState(event);
    }
  }

  Stream<VideosState> _mapLoadVideosToState() async* {
    _videosSubscription?.cancel();
    try {
      _videosSubscription = _videosRepository.videos().listen(
            (videos) => add(VideosUpdated(videos)),
          );
    } catch (_) {
      yield state.copyWith(
          status: VideosStatus.failure, error: _.error.toString());
    }
  }

  Stream<VideosState> _mapAddVideoToState(AddVideo event) async* {
    try {
      _videosRepository.addNewVideo(event.video);
    } catch (_) {
      yield state.copyWith(
          status: VideosStatus.failure, error: _.error.toString());
    }
  }

  Stream<VideosState> _mapUpdateVideoToState(UpdateVideo event) async* {
    try {
      _videosRepository.updateVideo(event.updatedVideo);
    } catch (_) {
      yield state.copyWith(
          status: VideosStatus.failure, error: _.error.toString());
    }
  }

  Stream<VideosState> _mapDeleteVideoToState(DeleteVideo event) async* {
    try {
      _videosRepository.deleteVideo(event.video);
    } catch (_) {
      yield state.copyWith(
          status: VideosStatus.failure, error: _.error.toString());
    }
  }

  /* Stream<VideosState> _mapToggleAllToState() async* {
    final currentState = state;
    if (currentState is VideosLoaded) {
      final allComplete = currentState.videos.every((video) => video.complete);
      final List<Video> updatedVideos = currentState.videos
          .map((video) => video.copyWith(complete: !allComplete))
          .toList();
      updatedVideos.forEach((updatedVideo) {
        _videosRepository.updateVideo(updatedVideo);
      });
    }
  }

  Stream<VideosState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is VideosLoaded) {
      final List<Video> completedVideos =
          currentState.videos.where((video) => video.complete).toList();
      completedVideos.forEach((completedVideo) {
        _videosRepository.deleteVideo(completedVideo);
      });
    }
  }*/

  Stream<VideosState> _mapVideosUpdateToState(VideosUpdated event) async* {
    if (state.status == VideosStatus.initial) {
      yield state.copyWith(status: VideosStatus.inprogress);
    }
    yield state.copyWith(
      status: VideosStatus.success,
      videos: event.videos,
    );
  }

  @override
  Future<void> close() {
    _videosSubscription?.cancel();
    return super.close();
  }
}
