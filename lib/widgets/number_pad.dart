import 'package:flutter/material.dart';
import 'package:yuppakids/widgets/colors.dart';

class NumberPad extends StatelessWidget {
  NumberPad({Key key}) : super(key: key);

  final String result = "5";
  final String operation = "2 + 3";

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 8,
            child: Text(operation,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: colorInput,
                  fontSize: 32.0,
                  fontStyle: FontStyle.normal,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 8,
            child: Text(result,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: isDark ? colorDarkResult : colorResult,
                  fontSize: 60.0,
                  fontStyle: FontStyle.normal,
                )),
          ),
        ),
        // buildHorizontalLine(context),
        Row(
          children: <Widget>[
            buildInputButton(context, "7"),
            // buildVerticalLine(context),
            buildInputButton(context, "8"),
            // buildVerticalLine(context),
            buildInputButton(context, "9"),
            // buildVerticalLine(context),
          ],
        ),
      ],
    );
  }

  Container buildWideInputButton(BuildContext context, String input,
      {String fontFamily = 'Raleway',
      Color color = colorInput,
      double fontSize = 32.0,
      FontWeight fontWeight = FontWeight.w500}) {
    var isEqualSign = input == "=";
    return Container(
      color: isEqualSign ? colorEqualsBackground : Colors.transparent,
      height: MediaQuery.of(context).size.width / 4,
      width: MediaQuery.of(context).size.width / 2 - (input == "DEL" ? 5 : 0),
      child: Center(
        child: Text(input,
            style: buildInputTextStyle(
                fontFamily: fontFamily,
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight)),
      ),
    );
  }

  Container buildInputButton(BuildContext context, String input,
      {String fontFamily = 'Raleway',
      Color color = colorInput,
      double fontSize = 32.0,
      FontWeight fontWeight = FontWeight.w500}) {
    return Container(
      width: MediaQuery.of(context).size.width / 8 - 3,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Center(
          child: Text(input,
              style: buildInputTextStyle(
                  fontFamily: fontFamily,
                  color: color,
                  fontSize: fontSize,
                  fontWeight: fontWeight)),
        ),
      ),
    );
  }

  TextStyle buildInputTextStyle(
      {String fontFamily = 'Raleway',
      Color color = colorInput,
      double fontSize = 32.0,
      FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: FontStyle.normal);
  }

  Container buildVerticalLine(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      width: 1.0,
      height: MediaQuery.of(context).size.width / 8,
      color: isDark ? colorDarkLine : colorLine,
    );
  }

  Container buildHorizontalLine(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1.0,
      color: isDark ? colorDarkLine : colorLine,
    );
  }
}
