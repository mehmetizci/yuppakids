import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yuppakids/widgets/widgets.dart';
import 'package:yuppakids/blocs/search/blocs.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Video Search'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final searchTerm = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchVideo(),
                ),
              );
              if (searchTerm != null) {
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchRequested(query: searchTerm));
              }
            },
          )
        ],
      ),
      body: Center(child:
          BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        if (state is SearchInitial) {
          return Center(child: Text('Please Select a Location'));
        }
        if (state is SearchLoadInProgress) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is SearchLoadSuccess) {
          final video = state.results[0].video.title;
          return Center(
            child: Text(video),
          );
        }
        if (state is SearchLoadFailure) {
          return Text(
            'Something went wrong!',
            style: TextStyle(color: Colors.red),
          );
        }
        return Center(
          child: Text("videos"),
        );
      })),
    );
  }
}
