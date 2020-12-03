import 'package:flutter/material.dart';

class SearchVideo extends StatefulWidget {
  @override
  State<SearchVideo> createState() => _SearchVideoState();
}

class _SearchVideoState extends State<SearchVideo> {
  final TextEditingController _textController = TextEditingController();

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Video'),
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 35,
                    width: double.infinity,
                    //   color: theme.primaryColor,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      //  color: theme.cardColor,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: theme.primaryColor),
                        Expanded(
                          child: TextField(
                            controller: description,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "Search by title, expertise, companies,"),
                          ),
                        ),
                        Icon(Icons.filter_alt).padding(8).ripple(() {
                          // displayFilterJob();
                        }),
                        // SizedBox(width:8),
                        Container(
                          color: theme.primaryColor,
                          child: Icon(Icons.search, color: Colors.amber).p(8),
                        ).cornerRadius(5).ripple(() {
                          if (description.text.isEmpty) return;
                          FocusManager.instance.primaryFocus.unfocus();
                          BlocProvider.of<JobBloc>(context)
                            ..add(SearchJobBy(description.text, null, null));
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
            /*BlocBuilder<JobBloc, JobState>(
              builder: (context, state) {
                if ((state is OnJobLoading)) {
                  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(height: 120),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(theme.primaryColor),
                      strokeWidth: 4,
                    ),
                  ]);
                } else if (state is ErrorJobListState) {
                  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    GErrorContainer(
                      title: "Server down :(",
                      description: "Try again in some time",
                    ),
                  ]);
                }
                if (state is LoadedJobsList) {
                  if (state.isNotNullEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GErrorContainer(
                          title: "No job found",
                          description: description.text.isEmpty ? "Try again in sometime" : "Try again with other keyword",
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    controller: _controller,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    itemCount: state.jobs.length + 1,
                    itemBuilder: (_, index) {
                      if (index == state.jobs.length) {
                        if (state is OnNextJobLoading) {
                          return Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation(theme.primaryColor),
                              ));
                        }
                        return SizedBox.shrink();
                      }
                      return JobTile(model: state.jobs[index]);
                    },
                  ).extended;
                }
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(theme.primaryColor),
                  strokeWidth: 4,
                );
              },
            )*/
          ],
        ),
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
