import 'package:flutter/material.dart';
import 'package:yuppakids/screens/home/components/video_grid.dart';
import 'package:yuppakids/screens/home/components/home_header.dart';
import 'package:yuppakids/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
              height: getProportionateScreenHeight(15), width: double.infinity),
          SearchHeader(),
          SizedBox(
              height: getProportionateScreenHeight(110),
              width: double.infinity),
          VideoGrid(),
        ],
      ),
    );
  }
}
