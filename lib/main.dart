import 'package:flutter/material.dart';
import 'package:yuppakids/simple_bloc_observer.dart';
import 'package:yuppakids/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppakids/blocs/search/blocs.dart';
import 'package:yuppakids/widgets/widgets.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final YoutubeRepository youtubeRepository = YoutubeRepository(
    youtubeApiClient: YoutubeApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(youtubeRepository: youtubeRepository));
}

class App extends StatelessWidget {
  final YoutubeRepository youtubeRepository;

  App({Key key, @required this.youtubeRepository})
      : assert(youtubeRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      home: BlocProvider(
        create: (context) => SearchBloc(youtubeRepository: youtubeRepository),
        child: Search(),
      ),
    );
  }
}
