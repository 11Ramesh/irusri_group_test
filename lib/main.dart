import 'dart:io';

import 'package:countries_app/const/certificate_verified.dart';
import 'package:countries_app/const/screenSize.dart';
import 'package:countries_app/logic/calculation/calculation_bloc.dart';
import 'package:countries_app/screen/home.dart';
import 'package:countries_app/screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  //solve CERTIFICATE_VERIFY_FAILED error
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
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
