import 'package:flutter/material.dart';
import 'package:yuppakids/screens/search/components/video_grid.dart';
import 'package:yuppakids/screens/search/components/search_header.dart';
import 'package:yuppakids/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
              height: getProportionateScreenHeight(20), width: double.infinity),
          SearchHeader(),
          SizedBox(
              height: getProportionateScreenHeight(120),
              width: double.infinity),
          VideoGrid(),
        ],
      ),
    );
  }
}
