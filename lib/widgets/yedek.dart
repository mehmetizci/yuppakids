import 'package:flutter/material.dart';
import 'package:yuppakids/models/models.dart';
import 'package:yuppakids/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppakids/blocs/search/blocs.dart';
import 'package:yuppakids/widgets/widgets.dart';
import 'package:flutter/services.dart';

class SearchVideo extends StatefulWidget {
  @override
  State<SearchVideo> createState() => _SearchVideoState();
}

class _SearchVideoState extends State<SearchVideo> {
  final TextEditingController _textController = TextEditingController();
  FocusNode _focus = new FocusNode();
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _focus.addListener(_onFocusChange);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  void _onFocusChange() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        // appBar: detailsAppBar(this.context),
        //resizeToAvoidBottomInset: true,
        // backgroundColor: Theme.of(context).backgroundColor,
        /*  appBar: AppBar(
        title: Text('Search Video'),
      ),*/
        body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/images/pampa.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: theme.colorScheme.onPrimary,
                        size: 48,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 200, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: theme.cardColor,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search,
                            color: theme.colorScheme.onPrimary, size: 48),
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                            focusNode: _focus,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {
                              if (_textController.text.isEmpty) return;
                              FocusManager.instance.primaryFocus.unfocus();
                              if (_textController.text != null) {
                                BlocProvider.of<SearchBloc>(context)
                                  ..add(SearchRequested(
                                      query: _textController.text));
                              }
                            },
                            autofocus: true,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                                hintText: "Youtube videolarda ara..."),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 300,
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 180),
                      child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          if (state is SearchInitial) {
                            return CenteredMessage(
                                icon: Icons.ondemand_video,
                                message: 'Start searching');
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
                                  height: 300,
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

                          /*    
                if ((state is SearchInitial)) {
                  return Center(child: Text('Lütfen arama yapın...'));
                } else if (state is SearchLoadFailure) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GErrorContainer(
                          title: "Server down :(",
                          description: "Try again in some time",
                        ),
                      ]);
                }
                if (state is SearchLoadSuccess) {
                  return ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    itemCount: state.results.length,
                    itemBuilder: (_, index) {
                      /* if (index == state.results.length) {
                        if (state is OnNextJobLoading) {
                          return Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor:
                                    AlwaysStoppedAnimation(theme.primaryColor),
                              ));
                        }
                        return SizedBox.shrink();
                      }*/
                      return Text(state.results[index].video.title);
                    },
                  ).extended;
                }
                if (state is SearchLoadInProgress) {
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(theme.primaryColor),
                    strokeWidth: 4,
                  );
                }*/
                        },
                      )),
                )
              ],
            ),
          ],
        ),
      );
    }));
  }

  Widget _buildLoaderListItem() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  bool _handleScrollNotification(
      ScrollNotification notification, SearchBloc _searchBloc) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      _searchBloc.state;
      return false;
    }
    return false;
  }

  Widget _buildVideoListItemCard(Video snippet) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  snippet.url,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              snippet.id,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(snippet.id),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    SystemChrome.restoreSystemUIOverlays();
    _focus.dispose();
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
