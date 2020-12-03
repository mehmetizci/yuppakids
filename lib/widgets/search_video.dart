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
      body: Form(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  controller: _textController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Ara',
                    hintText: 'Youtube videolar içinde ara...',
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pop(context, _textController.text);
              },
            )
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
