import 'package:equatable/equatable.dart';
import 'package:yuppakids/models/video.dart';

class Results extends Equatable {
  final Video video;

  Results({this.video});

  static Results fromJson(Map<String, dynamic> json) {
    final video = json['video'] != null ? Video.fromJson(json['video']) : null;
    return Results(video: video);
  }

  @override
  List<Object> get props => [video];
}
