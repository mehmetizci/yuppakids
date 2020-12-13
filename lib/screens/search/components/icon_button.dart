import 'package:flutter/material.dart';
import 'package:yuppakids/size_config.dart';

class IconBtn extends StatelessWidget {
  const IconBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.25,
      alignment: Alignment.centerLeft,
      height: getProportionateScreenHeight(80),
      child: IconButton(
          alignment: Alignment.center,
          onPressed: () => Navigator.pop(context),
          iconSize: 48,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
    );
  }
}
