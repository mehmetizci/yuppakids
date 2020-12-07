import 'package:flutter/material.dart';
import 'package:yuppakids/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppakids/blocs/search/blocs.dart';
import 'package:yuppakids/widgets/widgets.dart';

class VideoGrid extends StatefulWidget {
  @override
  State<VideoGrid> createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchBloc = BlocProvider.of<SearchBloc>(context);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      _searchBloc.add(FetchNextPage());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.80,
      // height: SizeConfig.screenHeight * 0.80,
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: getProportionateScreenHeight(480),
        child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          if (state is SearchInitial) {
            return CenteredMessage(
                icon: Icons.ondemand_video, message: 'Aramaya başlayın');
          }
          if (state is SearchLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchLoadSuccess) {
            return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.results.length + 1,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return index >= state.results.length
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          // height: 200,
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.network(
                              state.results[index].video.thumbnailSrc,
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                          ),
                        );
                },
              ),
            );
          }
          return CenteredMessage(
            icon: Icons.error_outline,
            message: "Server down :(",
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      // _postBloc.add(PostFetched());
    }
  }
}
