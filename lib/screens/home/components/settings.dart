import 'package:flutter/material.dart';
import 'package:yuppakids/screens/settings/parental_settings.dart';

class Settings extends StatelessWidget {
  final double sizeFactor;
  final double innerSize;

  Settings({this.sizeFactor, this.innerSize});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: 64,
        height: 64,
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
            color: Colors.amberAccent,
            boxShadow: [BoxShadow(color: Colors.amberAccent, blurRadius: 10)],
            borderRadius: BorderRadius.circular(60),
            border: Border.all(
              color: Colors.amberAccent,
              width: 1,
            )),
        child: IconButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ParentalSettings()),
            )
          },
          alignment: Alignment.center,
          icon: Icon(
            Icons.settings,
            color: Colors.white,
            size: 48,
          ),
        ),
      ),
    );
  }
}
