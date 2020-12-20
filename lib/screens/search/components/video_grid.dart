import 'package:flutter/material.dart';
import 'package:yuppakids/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppakids/blocs/blocs.dart';
import 'package:yuppakids/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:yuppakids/models/firestore/models.dart';

class VideoGrid extends StatefulWidget {
  @override
  State<VideoGrid> createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  final _scrollController = ScrollController();
  SearchBloc _searchBloc;
  final assetsAudioPlayerRight = AssetsAudioPlayer();
  final assetsAudioPlayerLeft = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.90,
      height: getProportionateScreenHeight(520),
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: getProportionateScreenHeight(520),
        child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          if (state.status == SearchStatus.failure) {
            CenteredMessage(
              icon: Icons.error_outline,
              message: state.error,
            );
          }
          if (state.status == SearchStatus.initial) {
            //print(state.nextPageToken);
            return CenteredMessage(
                icon: Icons.ondemand_video, message: 'Aramaya başlayın...');
          }
          if (state.status == SearchStatus.inprogress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == SearchStatus.success) {
            return NotificationListener<ScrollUpdateNotification>(
                onNotification: _handleScrollNotification,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.nextPageToken.isEmpty
                      ? state.results.length
                      : state.results.length + 1,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return index >= state.results.length
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
                                        state.results[index].video.thumbnailSrc,
                                        fit: BoxFit.cover),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: ListTile(
                                        title: Text(
                                          state.results[index].video.title,
                                          textScaleFactor: 0.6,
                                          maxLines: 2,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        ),
                                        trailing: IconButton(
                                            alignment: Alignment.center,
                                            onPressed: () => {
                                                  BlocProvider.of<VideosBloc>(
                                                          context)
                                                      .add(
                                                    AddVideo(Video(
                                                      userId: 'memoli',
                                                      profileId: '2',
                                                      videoId: state
                                                          .results[index]
                                                          .video
                                                          .id,
                                                      videoTitle: state
                                                          .results[index]
                                                          .video
                                                          .title,
                                                      videoSnippet: state
                                                          .results[index]
                                                          .video
                                                          .snippet,
                                                      videoUrl: state
                                                          .results[index]
                                                          .video
                                                          .url,
                                                      imageUrl: state
                                                          .results[index]
                                                          .video
                                                          .thumbnailSrc,
                                                      duration: state
                                                          .results[index]
                                                          .video
                                                          .duration,
                                                      channelUrl: state
                                                          .results[index]
                                                          .video
                                                          .channelUrl,
                                                    )),
                                                  )
                                                },
                                            iconSize: 16,
                                            icon: Icon(
                                              Icons.playlist_add,
                                              color: Colors.red,
                                            )),
                                        onTap: () {
                                          //Go to the next screen with Navigator.push
                                        },
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
              icon: Icons.ondemand_video, message: 'Aramaya başlayın');
        }),
      ),
    );
  }

  bool _handleScrollNotification(ScrollUpdateNotification notification) {
    if (_scrollController.position.extentAfter == 0) {
      _searchBloc.add(FetchNextPage());
      //notification is ScrollEndNotification &&
    }

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
    _searchBloc.add(ResetState());
    assetsAudioPlayerRight.dispose();
    assetsAudioPlayerLeft.dispose();
    super.dispose();
  }

  /*void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _searchBloc.add(FetchNextPage());
    }
  }*/

  /*void _onScroll() {
    if (_isBottom) _searchBloc.add(FetchNextPage());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }*/
}
