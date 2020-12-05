import 'package:flutter/material.dart';
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
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 35,
                    width: double.infinity,
                    color: theme.primaryColor,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: theme.cardColor,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: theme.primaryColor),
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            focusNode: _focus,
                            /*onTap: () =>
                                SystemChrome.setEnabledSystemUIOverlays([]),*/
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Youtube videolarda ara...,"),
                          ),
                        ),
                        Icon(Icons.filter_alt).p(8).ripple(() {
                          // displayFilterJob();
                        }),
                        // SizedBox(width:8),
                        Container(
                          color: theme.primaryColor,
                          child: Icon(Icons.search,
                                  color: theme.colorScheme.onPrimary)
                              .p(8),
                        ).cornerRadius(5).ripple(() {
                          if (_textController.text.isEmpty) return;
                          FocusManager.instance.primaryFocus.unfocus();
                          if (_textController.text != null) {
                            BlocProvider.of<SearchBloc>(context)
                              ..add(SearchRequested(
                                  searchTerm: _textController.text));
                          }
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
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
                }
              },
            )
          ],
        ),
      );
    }));
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
