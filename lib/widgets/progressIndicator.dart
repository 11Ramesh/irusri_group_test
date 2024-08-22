import 'package:countries_app/const/screenSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//this is progress indicator widget.
//this use for progress indicator in home screen
// i use diferent dependency  get this it name 'flutter_spinkit'
class ProcessIndicatorCustom extends StatelessWidget {
  ProcessIndicatorCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil.screenHeight * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        alignment: Alignment.bottomCenter,
        child: const SpinKitFadingCircle(
          color: Colors.blue,
          size: 80.0,
        ));
  }
}
