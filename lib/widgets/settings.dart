import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  final double sizeFactor;
  final double innerSize;

  Settings({this.sizeFactor, this.innerSize});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: Container(
        width: MediaQuery.of(context).size.width * sizeFactor,
        height: MediaQuery.of(context).size.width * sizeFactor,
        decoration: BoxDecoration(
            color: Colors.amberAccent,
            boxShadow: [BoxShadow(color: Colors.amberAccent, blurRadius: 10)],
            borderRadius: BorderRadius.circular(60),
            border: Border.all(
              color: Colors.amberAccent,
              width: 1,
            )),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          alignment: Alignment.center,
          tooltip: 'ayarlar...',
          icon: Icon(
            Icons.settings,
            color: Colors.white,
            size: MediaQuery.of(context).size.width * innerSize,
          ),
        ),
      ),
    );
  }
}
