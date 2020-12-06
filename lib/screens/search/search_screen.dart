import 'package:flutter/material.dart';
import 'package:yuppakids/size_config.dart';
import 'package:yuppakids/screens/search/components/body.dart';
import 'package:yuppakids/models/models.dart';
import 'package:yuppakids/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppakids/blocs/search/blocs.dart';
import 'package:yuppakids/widgets/widgets.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static String routeName = "/search";

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }

  void _onFocusChange() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    SystemChrome.restoreSystemUIOverlays();

    super.dispose();
  }
}
