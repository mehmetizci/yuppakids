import 'package:flutter/material.dart';
import 'package:yuppakids/widgets/widgets.dart';
import 'package:yuppakids/size_config.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var sizeFactor = 0.09;
    var innerSize = sizeFactor - 0.025;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
