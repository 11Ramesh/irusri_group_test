import 'dart:io';

import 'package:countries_app/const/screenSize.dart';
import 'package:countries_app/logic/calculation/calculation_bloc.dart';
import 'package:countries_app/widgets/dropdown.dart';
import 'package:countries_app/widgets/height.dart';
import 'package:countries_app/widgets/message.dart';
import 'package:countries_app/widgets/progressIndicator.dart';
import 'package:countries_app/widgets/textshow.dart';
import 'package:countries_app/widgets/width.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//this is home screen.
//DropDownBox, Messages, TextShow, ProcessIndicatorCustom widgets. there are initialize in widget folder
//
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dio = Dio();
  List<dynamic> countries = [];

  String selectedValue = "Name";
  late CalculationBloc calculationBloc;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  //initialy declared bloc and in the initialy send data to event for load data to home screen
  initialization() async {
    calculationBloc = BlocProvider.of<CalculationBloc>(context);
    calculationBloc.add(DataGetEvent(selectedValue));
  }

  //this is show dialog box. this use for show aditional contry data view.
  //i design it this page. when anothor page it create. dificult to get maintain with bloc
  //.when it create anpther page . then i need to call bloc initsatate and  void disposed
  // it somewhat dificult
  void showDialogBox(BuildContext context, int id) {
    final country = countries[id];
    final officialName = country?['name']?['official'] ?? 'N/A';
    final population = country?['population']?.toString() ?? 'N/A';
    final flag = country['flags']['png'] ?? "http://via.placeholder.com/300";

    Map<String, dynamic>? languagesMap =
        country?['languages'] as Map<String, dynamic>? ?? {};
    final languages = languagesMap.entries
        .map((entry) => '${entry.value} (${entry.key})')
        .toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //contentPadding: EdgeInsets.only(left: 10, right: 10),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    flag,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Height(value: 0.02),
              TextShow(
                text: officialName,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Height(value: 0.01),
              Row(
                children: [
                  TextShow(
                    text: "Population:   ",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  TextShow(text: population, fontSize: 15),
                ],
              ),
              Height(value: 0.03),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextShow(
                    text: 'Languages:   ',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (languages.isNotEmpty)
                        ...languages
                            .map((language) => TextShow(
                                  text: language,
                                  fontSize: 15,
                                ))
                            .toList(),
                      if (languages.isEmpty) Text('Languages: N/A'),
                    ],
                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: TextShow(
                    text: 'Ok',
                    fontSize: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: TextShow(
          text: "Countries App",
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
        centerTitle: true,
      ),
      //listview builder i create in this page . because
      //when it it crate aother page somewhat dificult to get tile index
      // using this page i can get tile index.
      //but code is longer than another page.
      body: Padding(
        padding: EdgeInsets.only(
            right: ScreenUtil.screenWidth * 0.02,
            left: ScreenUtil.screenWidth * 0.02),
        child: Scaffold(
          backgroundColor: Colors.white,
          //Sortby widget include in this section
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              DropDownBox(
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                    calculationBloc.add(DataGetEvent(selectedValue));
                  });
                },
                selectedValue: selectedValue,
              ),
            ],
            backgroundColor: Colors.white,
          ),
          body: BlocConsumer<CalculationBloc, CalculationState>(
            listener: (context, state) {
              //check state has eror
              //when it has error show floating message
              if (state is DataGetErrorState) {
                String error = state.error;
                Messages(context).showError(error);
              }
            },
            builder: (context, state) {
              //get data from state
              if (state is DataGetState) {
                countries = state.countries;
                print(countries.length);
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              country['flags']['png'] ??
                                  "http://via.placeholder.com/300",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextShow(
                                  text: country['name']['common'] ?? 'N/A',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                TextShow(
                                    text:
                                        "Capital: ${country['capital'][0] ?? 'N/A'}",
                                    fontSize: 14.0,
                                    color: Colors.grey[600]),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialogBox(context, index);
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 25,
                                )),
                          ],
                        ),
                        tileColor: Color.fromARGB(81, 255, 255, 255),
                      ),
                    );
                  },
                );
              } else if (state is DataGetLoadingState) {
                return ProcessIndicatorCustom();
              } else {
                return ProcessIndicatorCustom();
              }
            },
          ),
        ),
      ),
    );
  }
}
