import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'calculation_event.dart';
part 'calculation_state.dart';

class CalculationBloc extends Bloc<CalculationEvent, CalculationState> {
  CalculationBloc() : super(CalculationInitial()) {
    on<CalculationEvent>((event, emit) async {
      // data get bloc this use for all data get
      if (event is DataGetEvent) {
        emit(DataGetLoadingState());
        final dio = Dio();
        String sortBy = event.sortBy;
        List<dynamic> countries = [];

        try {
          //request data get from the api 
          Response response = await dio.get(
            'https://restcountries.com/v3.1/region/europe?fields=name,capital,flags,region,languages,population,capital',
            options: Options(
              headers: {
                'Accept': 'application/json',
              },
            ),
          );
          // api data store in the list
          final List<dynamic> responseData = response.data;

          countries = responseData;
          // sort data this use for sort data. tree type of data sort.i used if else, swithch operation use can do this 
          //sor by name, population, capital
          if (sortBy == "Name") {
            countries.sort(
                (a, b) => a['name']['common'].compareTo(b['name']['common']));
          } else if (sortBy == "Population") {
            countries
                .sort((a, b) => a['population'].compareTo(b['population']));
          } else if (sortBy == "Population") {
            countries.sort((a, b) => a['capital'].compareTo(b['capital']));
          } else {
            countries = responseData;
          }
          // error handling state this use for error handling. connection Error and another errors show as floting message
          //
        } catch (e) {
          if (e.runtimeType == DioException) {
            emit(DataGetErrorState(
                error:
                    "Connection error. Please check your internet connection."));
          } else {
            emit(DataGetErrorState(error: e.toString()));
          }
        }
        emit(DataGetState(countries: countries));
      }
    });
  }
}
