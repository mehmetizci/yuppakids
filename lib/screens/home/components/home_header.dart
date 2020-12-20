import 'package:flutter/material.dart';
import 'package:yuppakids/size_config.dart';
import 'package:yuppakids/widgets/widgets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth,
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Settings(),
            Searching(),
            //SizedBox(width: SizeConfig.screenWidth * 0.3)
          ] /*ListTile(
        minLeadingWidth: SizeConfig.screenWidth * 0.3,
        leading: IconBtn(),
        title: SearchField(),
        trailing: SizedBox(width: SizeConfig.screenWidth * 0.3),
      )*/
          ,
        ));
  }
}
