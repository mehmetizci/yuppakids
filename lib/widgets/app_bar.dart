import 'package:flutter/material.dart';

AppBar detailsAppBar(BuildContext context) {
  detailsAppBar(context);
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: 36,
      ),
      onPressed: () => Navigator.pop(context),
    ),
    actions: <Widget>[
      /* IconButton(
        icon: SvgPicture.asset("assets/icons/share.svg"),
        iconSize: 36,
        onPressed: () {},
      ),
      IconButton(
        icon: SvgPicture.asset("assets/icons/more.svg"),
        iconSize: 36,
        onPressed: () {},
      ),*/
    ],
  );
}
