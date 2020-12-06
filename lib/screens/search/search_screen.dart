import 'package:flutter/material.dart';
import 'package:yuppakids/size_config.dart';
import 'package:yuppakids/screens/search/components/body.dart';
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/pampa.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Body(),
      ),
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
