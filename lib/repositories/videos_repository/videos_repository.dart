import 'dart:async';

import 'package:yuppakids/repositories/repositories.dart';

abstract class VideosRepository {
  Future<void> addNewVideo(Video video);

  Future<void> deleteVideo(Video video);

  Stream<List<Video>> videos();

  Future<void> updateVideo(Video video);
}
