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
                    .add(SearchRequested(searchTerm: searchTerm));
              }
            },
          )
        ],
      ),
    );
  }
}
