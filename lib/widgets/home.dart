import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yuppakids/widgets/widgets.dart';
import 'package:yuppakids/blocs/search/blocs.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sizeFactor = 0.06;
    var innerSize = sizeFactor - 0.025;
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/images/pampa.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      Searching(sizeFactor: sizeFactor, innerSize: innerSize),
      Settings(sizeFactor: sizeFactor, innerSize: innerSize),
    ]));
  }
}
