import 'package:countries_app/const/screenSize.dart';
import 'package:flutter/material.dart';

//widget for height. this use for get empty heigt.
//only give value only it is double value
// this double value multifly with screen height
class Height extends StatelessWidget {
  double value;
  Height({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil.screenWidth * value,
    );
  }
}
