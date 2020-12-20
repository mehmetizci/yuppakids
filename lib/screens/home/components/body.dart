import 'package:flutter/material.dart';
import 'package:yuppakids/screens/home/components/home_header.dart';
import 'package:yuppakids/screens/home/components/video_grid.dart';
import 'package:yuppakids/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
              height: getProportionateScreenHeight(15), width: double.infinity),
          HomeHeader(),
          SizedBox(
              height: getProportionateScreenHeight(30), width: double.infinity),
          VideoGrid(),
        ],
      ),
    );
  }
}
