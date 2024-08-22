import 'package:countries_app/const/screenSize.dart';
import 'package:flutter/material.dart';

//width for widths. this use for get empty widths.
//only give value only it is double value
// this double value multifly with screen widths
class Widths extends StatelessWidget {
  double value;
  Widths({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil.screenWidth * value,
    );
  }
}
