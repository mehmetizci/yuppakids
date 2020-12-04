import 'package:flutter/material.dart';
import 'package:yuppakids/widgets/search_video.dart';

class Searching extends StatelessWidget {
  final double sizeFactor;
  final double innerSize;

  Searching({this.sizeFactor, this.innerSize});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 20,
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
          onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchVideo()))
          },
          alignment: Alignment.center,
          tooltip: 'video ara...',
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: MediaQuery.of(context).size.width * innerSize,
          ),
        ),
      ),
    );
  }
}
