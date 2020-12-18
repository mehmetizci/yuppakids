import 'package:flutter/material.dart';
import 'package:yuppakids/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppakids/blocs/videos/videos.dart';
import 'package:yuppakids/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

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
      height: getProportionateScreenHeight(480),
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: getProportionateScreenHeight(460),
        child: BlocBuilder<VideosBloc, VideosState>(builder: (context, state) {
          if (state  is VideosNotLoaded) {
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        state.results[index].video.title,
                                        maxLines: 1,
                                        textScaleFactor: 0.8,
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
