import 'package:meta/meta.dart';
import 'package:yuppakids/repositories/videos_repository/entities/video_entity.dart';

@immutable
class Video {
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
  Video({
    this.id,
    this.userId,
    this.profileId,
    this.videoId,
    this.videoTitle,
    this.videoSnippet,
    this.videoUrl,
    this.imageUrl,
    this.duration,
    this.channelUrl,
  });

  Video copyWith({
    String id,
    String userId,
    String profileId,
    String videoId,
    String videoTitle,
    String videoSnippet,
    String videoUrl,
    String imageUrl,
    String duration,
    String channelUrl,
  }) {
    return Video(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      profileId: profileId ?? this.profileId,
      videoId: videoId ?? this.videoId,
      videoTitle: videoTitle ?? this.videoTitle,
      videoSnippet: videoSnippet ?? this.videoSnippet,
      videoUrl: videoUrl ?? this.videoUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      duration: duration ?? this.duration,
      channelUrl: channelUrl ?? this.channelUrl,
    );
  }

  /* @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      profileId.hashCode ^
      videoId.hashCode ^
      videoTitle.hashCode ^
      videoUrl.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Video &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          profileId == other.profileId &&
          videoId == other.videoId &&
          videoTitle == other.videoTitle &&
          videoUrl == other.videoUrl;
*/
  @override
  String toString() {
    return 'Video {id: $id, userId: $userId, profileId: $profileId, videoId: $videoId, videoTitle: $videoTitle, videoSnippet: $videoSnippet, videoUrl: $videoUrl, imageUrl: $imageUrl, duration: $duration, channelUrl:$channelUrl}';
  }

  VideoEntity toEntity() {
    return VideoEntity(id, userId, profileId, videoId, videoTitle, videoSnippet,
        videoUrl, imageUrl, duration, channelUrl);
  }

  static Video fromEntity(VideoEntity entity) {
    return Video(
      id: entity.id,
      userId: entity.userId,
      profileId: entity.profileId,
      videoId: entity.videoId,
      videoTitle: entity.videoTitle,
      videoSnippet: entity.videoSnippet,
      videoUrl: entity.videoUrl,
      imageUrl: entity.imageUrl,
      duration: entity.duration,
      channelUrl: entity.channelUrl,
    );
  }
}
