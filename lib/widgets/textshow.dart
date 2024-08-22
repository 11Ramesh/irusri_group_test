import 'package:flutter/material.dart';

// this widget use for text show.
// text, font size, font weight, color include
//not use 'Text()' every ware use this widgets
class TextShow extends StatelessWidget {
  TextShow(
      {required this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      super.key});
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}
