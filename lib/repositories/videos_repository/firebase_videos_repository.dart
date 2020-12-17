import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yuppakids/repositories/videos_repository/video_repository.dart';
import 'package:yuppakids/repositories/videos_repository/entities/video_entity.dart';

class FirebaseVideosRepository implements VideosRepository {
  final videoCollection = FirebaseFirestore.instance.collection('videos');

  @override
  Future<void> addNewVideo(Video video) {
    return videoCollection.add(video.toEntity().toDocument());
  }

  @override
  Future<void> deleteVideo(Video video) async {
    return videoCollection.doc(video.id).delete();
  }

  @override
  Stream<List<Video>> videos() {
    return videoCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Video.fromEntity(VideoEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateVideo(Video update) {
    return videoCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }
}
