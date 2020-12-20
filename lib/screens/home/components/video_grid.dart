import 'package:flutter/material.dart';
import 'package:yuppakids/models/firestore/video.dart';
import 'package:yuppakids/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppakids/blocs/blocs.dart';
import 'package:yuppakids/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class VideoGrid extends StatefulWidget {
  @override
  State<VideoGrid> createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  final _scrollController = ScrollController();

  final assetsAudioPlayerRight = AssetsAudioPlayer();
  final assetsAudioPlayerLeft = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.90,
      height: getProportionateScreenHeight(500),
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: getProportionateScreenHeight(500),
        child: BlocBuilder<VideosBloc, VideosState>(builder: (context, state) {
          if (state.status == VideosStatus.failure) {
            CenteredMessage(
              icon: Icons.error_outline,
              message: state.error,
            );
          }
          if (state.status == VideosStatus.initial) {
            //print(state.nextPageToken);
            return CenteredMessage(
                icon: Icons.ondemand_video, message: 'Aramaya başlayın...');
          }
          if (state.status == VideosStatus.inprogress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == VideosStatus.success) {
            return NotificationListener<ScrollUpdateNotification>(
                onNotification: _handleScrollNotification,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.videos.length > 0
                      ? state.videos.length
                      : state.videos.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return index >= state.videos.length
                        ? BottomLoader()
                        : Container(
                            height: double.infinity,
                            width: SizeConfig.screenWidth * 0.30,
                            child: Card(
                              elevation: 5,
                              margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: getProportionateScreenHeight(360),
                                    child: Image.network(
                                        (state.videos[index] as Video).imageUrl,
                                        fit: BoxFit.cover),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        (state.videos[index] as Video)
                                            .videoTitle,
                                        maxLines: 2,
                                        textScaleFactor: 0.6,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                ));
          }
          return CenteredMessage(
              icon: Icons.ondemand_video, message: 'Henüz hiç video yok');
        }),
      ),
    );
  }

  bool _handleScrollNotification(ScrollUpdateNotification notification) {
    /*  if (_scrollController.position.extentAfter == 0) {
      _searchBloc.add(FetchNextPage());
      
    }*/

    if (notification.scrollDelta < 0) {
      assetsAudioPlayerLeft.open(
        Audio("assets/sounds/swipe_left.wav"),
      );
    }
    if (notification.scrollDelta > 0) {
      assetsAudioPlayerRight.open(
        Audio("assets/sounds/swipe_right.wav"),
      );
    }

    return false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    assetsAudioPlayerRight.dispose();
    assetsAudioPlayerLeft.dispose();
    super.dispose();
  }
}
