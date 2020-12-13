import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yuppakids/size_config.dart';
import 'package:yuppakids/widgets/shake_view.dart';
import 'package:yuppakids/utils/pin_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ParentalSettings extends StatefulWidget {
  ParentalSettings({Key key}) : super(key: key);

  @override
  _ParentalSettings createState() => _ParentalSettings();
}

class _ParentalSettings extends State<ParentalSettings>
    with TickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  static String routeName = "/parental_settings";
  AnimationController animationController;
  Animation animation;
  bool isPlaying = false;
  ShakeController _shakeController;
  int pinCounter = 0;
  String pinDigits = "";

  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _shakeController = ShakeController(vsync: this);
    flutterTts.setLanguage("tr-TR");

    SystemChrome.setEnabledSystemUIOverlays([]);
    animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0, end: 60).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    setPinDigits();
    _speak();
  }

  Future _speak() async {
    await flutterTts.setSpeechRate(1);
    await flutterTts.setPitch(1);
    var result = await flutterTts
        .speak("Bu kısımda büyüklerinden yardım alsan iyi olur");
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    animationController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  void incrementPinCounter() {
    setState(() => pinCounter++);
  }

  void resetPinCounter() {
    setState(() => pinCounter = 0);
  }

  void setPinDigits() {
    setState(() => pinDigits = PinController.generatePin());
  }

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying ? animationController.forward() : animationController.reverse();
      Navigator.pop(context);
      // _shakeController.shake();
    });
  }

  Widget flatButton(
      BuildContext context, String pinDigits, int digit, int index) {
    return FlatButton(
      height: getProportionateScreenHeight(200),
      minWidth: getProportionateScreenWidth(200),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(color: Colors.white)),
      color: Colors.white,
      textColor: Colors.red,
      padding: EdgeInsets.all(5.0),
      onPressed: () async {
        bool retval = PinController.pinDecoder(pinDigits, digit, index);
        if (!retval) {
          assetsAudioPlayer.open(
            Audio("assets/sounds/failure.wav"),
          );
          _shakeController.shake();
          setPinDigits();
          resetPinCounter();
        } else {
          incrementPinCounter();
          assetsAudioPlayer.open(
            Audio("assets/sounds/tus.wav"),
          );
          if (pinCounter == 3) Navigator.pop(context);
        }
      },
      child: Text(
        digit.toString(),
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: VerticalSplitView(
        left: Container(
          decoration: BoxDecoration(
            color: Colors.amber[600],
            image: DecorationImage(
              image: AssetImage("assets/images/fare.png"),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        right: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 61, 0, 1),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    iconSize: 48,
                    splashColor: Colors.greenAccent,
                    color: Colors.white,
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.close_menu,
                      progress: animationController,
                    ),
                    onPressed: () => _handleOnPressed(),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Text(
                "Lütfen aşağıdaki sayıları giriniz...",
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                pinDigits,
                style: TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              ShakeView(
                controller: _shakeController,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    flatButton(context, pinDigits, 1, pinCounter),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    flatButton(context, pinDigits, 2, pinCounter),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    flatButton(context, pinDigits, 3, pinCounter),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              ShakeView(
                controller: _shakeController,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    flatButton(context, pinDigits, 4, pinCounter),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    flatButton(context, pinDigits, 5, pinCounter),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    flatButton(context, pinDigits, 6, pinCounter),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              ShakeView(
                controller: _shakeController,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    flatButton(context, pinDigits, 7, pinCounter),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    flatButton(context, pinDigits, 8, pinCounter),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    flatButton(context, pinDigits, 9, pinCounter),
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}

class VerticalSplitView extends StatelessWidget {
  final Widget left;
  final Widget right;

  const VerticalSplitView({Key key, @required this.left, @required this.right})
      : assert(left != null),
        assert(right != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 4 / 10,
              child: left,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 6 / 10,
              child: right,
            ),
          ],
        ),
      ),
    );
  }
}
