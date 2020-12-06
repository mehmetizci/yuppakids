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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      height: SizeConfig.screenHeight * 0.8,
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: getProportionateScreenHeight(380),
        child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          if (state is SearchInitial) {
            return CenteredMessage(
                icon: Icons.ondemand_video, message: 'Start searching');
          }
          if (state is SearchLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchLoadSuccess) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.results.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Container(
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
