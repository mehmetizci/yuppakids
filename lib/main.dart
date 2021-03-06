import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuppakids/simple_bloc_observer.dart';
import 'package:yuppakids/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppakids/blocs/search/blocs.dart';
import 'package:yuppakids/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloc/bloc.dart';
import 'package:yuppakids/blocs/authentication/bloc.dart';
import 'package:yuppakids/blocs/videos/videos.dart';
import 'package:yuppakids/database/app_database.dart';
import 'package:yuppakids/utils/prefs_singleton.dart';
import 'package:yuppakids/utils/shared_prefences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PrefsSingleton.prefs = await SharedPreferences.getInstance();
  SharedUserPreferences pref = SharedUserPreferences();
  pref.setUserId();
  print(pref.userId);
  print(pref.profileId);
  print(pref.profileName);
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();

  final YoutubeRepository youtubeRepository = YoutubeRepository(
    youtubeApiClient: YoutubeApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(KidsApp(youtubeRepository: youtubeRepository));
}

class KidsApp extends StatelessWidget {
  final YoutubeRepository youtubeRepository;

  KidsApp({Key key, @required this.youtubeRepository})
      : assert(youtubeRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(
              userRepository: FirebaseUserRepository(),
            )..add(AppStarted());
          },
        ),
        BlocProvider<SearchBloc>(
            create: (BuildContext context) =>
                SearchBloc(youtubeRepository: youtubeRepository)),
        BlocProvider<VideosBloc>(
          create: (context) {
            return VideosBloc(
              videosRepository: FirebaseVideosRepository(),
            )..add(LoadVideos());
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YuppaKids',
        home: Splash(),
      ),
    );
  }
}
