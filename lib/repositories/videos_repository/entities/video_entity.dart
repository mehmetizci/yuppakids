import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String id;
  final String userId;
  final String profileId;
  final String videoId;
  final String videoTitle;
  final String videoSnippet;
  final String videoUrl;
  final String imageUrl;
  final String duration;
  final String channelUrl;

  const VideoEntity(
      this.id,
      this.userId,
      this.profileId,
      this.videoId,
      this.videoTitle,
      this.videoSnippet,
      this.videoUrl,
      this.imageUrl,
      this.duration,
      this.channelUrl);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'profileId': profileId,
      'videoId': videoId,
      'videoTitle': videoTitle,
      'videoSnippet': videoSnippet,
      'videoUrl': videoUrl,
      'imageUrl': imageUrl,
      'duration': duration,
      'channelUrl': channelUrl,
    };
  }

  @override
  List<dynamic> get props => [
        id,
        userId,
        profileId,
        videoId,
        videoTitle,
        videoSnippet,
        videoUrl,
        imageUrl,
        duration,
        channelUrl,
      ];

  @override
  String toString() {
    return 'VideoEntity {id: $id, userId: $userId, profileId: $profileId, videoId: $videoId, videoTitle: $videoTitle, videoSnippet: $videoSnippet, videoUrl: $videoUrl, imageUrl: $imageUrl, duration: $duration, channelUrl:$channelUrl}';
  }

  static VideoEntity fromJson(Map<String, dynamic> json) {
    return VideoEntity(
      json['Id'] as String,
      json['userId'] as String,
      json['profileId'] as String,
      json['videoId'] as String,
      json['videoTitle'] as String,
      json['videoSnippet'] as String,
      json['videoUrl'] as String,
      json['imageUrl'] as String,
      json['duration'] as String,
      json['channelUrl'] as String,
    );
  }

  static VideoEntity fromSnapshot(DocumentSnapshot snap) {
    return VideoEntity(
      snap.id,
      snap.data()['userId'],
      snap.data()['profileId'],
      snap.data()['videoId'],
      snap.data()['videoTitle'],
      snap.data()['videoSnippet'],
      snap.data()['videoUrl'],
      snap.data()['imageUrl'],
      snap.data()['duration'],
      snap.data()['channelUrl'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'userId': userId,
      'profileId': profileId,
      'videoId': videoId,
      'videoTitle': videoTitle,
      'videoSnippet': videoSnippet,
      'videoUrl': videoUrl,
      'imageUrl': imageUrl,
      'duration': duration,
      'channelUrl': channelUrl,
    };
  }
}
