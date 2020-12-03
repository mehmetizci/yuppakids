import 'package:flutter/material.dart';

class SearchGrid extends StatelessWidget {
  final double sizeFactor;
  final double innerSize;

  SearchGrid({this.sizeFactor, this.innerSize});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.2,
        left: 20,
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 1,
                childAspectRatio: 9 / 16,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                      /* child: FutureBuilder<Video>(
                      future: futureVideo,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return VideoScreen(id: snapshot.data.id);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      },
                    ),*/
                      ),
                ],
              ),
            );
          },
        ));
  }
}
