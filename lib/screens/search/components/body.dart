import 'package:flutter/material.dart';
import 'package:yuppakids/screens/search/components/video_grid.dart';

import 'package:yuppakids/size_config.dart';
import 'package:yuppakids/screens/search/components/search_header.dart';
import 'package:yuppakids/screens/search/components/video_grid.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/images/pampa.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20, width: double.infinity),
              SearchHeader(),
              SizedBox(height: 20, width: double.infinity),
              VideoGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
