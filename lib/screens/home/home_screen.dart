import 'package:flutter/material.dart';
import 'package:yuppakids/screens/home/components/body.dart';
import 'package:flutter/services.dart';
import 'package:yuppakids/size_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String routeName = "/homescreen";

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

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    SystemChrome.restoreSystemUIOverlays();
    super.dispose();
  }
}
