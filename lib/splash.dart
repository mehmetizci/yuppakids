import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
//import 'package:flutter/services.dart';
import 'package:yuppakids/screens/home/home_screen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    //  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: HomeScreen(),
      title: new Text(
        'YuppaKids başlıyor...',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.asset('assets/images/logo.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }
}
