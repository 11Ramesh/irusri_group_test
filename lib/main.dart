import 'dart:io';

import 'package:countries_app/const/certificate_verified.dart';
import 'package:countries_app/const/screenSize.dart';
import 'package:countries_app/logic/calculation/calculation_bloc.dart';
import 'package:countries_app/screen/home.dart';
import 'package:countries_app/screen/splashScreen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  //solve CERTIFICATE_VERIFY_FAILED error
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());

  /*
  use this for check responsive the app
  uncomment and run it when you want to check responsive the app
  when it use 'runApp(const MyApp());' it comment
  */

  // runApp(
  //   DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(),
  // ),
  // );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //initialize get screen Height and width
    ScreenUtil.init(context);
    return BlocProvider(
      //initialize bloc i use Blocprovider its CalulationBloc
      create: (context) => CalculationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
