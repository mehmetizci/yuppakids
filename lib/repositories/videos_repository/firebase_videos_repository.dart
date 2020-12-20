import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yuppakids/repositories/videos_repository/video_repository.dart';
import 'package:yuppakids/entities/video_entity.dart';
import 'package:yuppakids/utils/shared_prefences.dart';

SharedUserPreferences pref = SharedUserPreferences();

class FirebaseVideosRepository implements VideosRepository {
  //final videoCollection = FirebaseFirestore.instance.collection('videos');

  final userCollection = FirebaseFirestore.instance.collection('users');
  final profileCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(pref.userId)
      .collection('profiles');
  final videoCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(pref.userId)
      .collection('profiles')
      .doc(pref.profileId)
      .collection('videos');

  Future<void> addNewUser(String userId) {
    return userCollection.doc('1').set({'userId': userId});
  }

  @override
  Future<void> addNewVideo(Video video) {
    print(pref.userId);
    return videoCollection
        .doc(video.toEntity().videoId)
        .set(video.toEntity().toDocument());
  }

  @override
  Future<void> deleteVideo(Video video) async {
    return videoCollection.doc(video.id).delete();
  }

  @override
  Stream<List<Video>> videos() {
    print(pref.userId);
    print(pref.profileId);
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
