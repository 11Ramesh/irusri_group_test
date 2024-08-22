import 'package:countries_app/widgets/textshow.dart';
import 'package:countries_app/widgets/width.dart';
import 'package:flutter/material.dart';

//this is drop down box
class DropDownBox extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  DropDownBox({
    required this.selectedValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextShow(text: 'Sort By :', fontSize: 16, fontWeight: FontWeight.bold),
        Widths(value: 0.02),
        DropdownButton<String>(
          value: selectedValue,
          items: <String>['Name', 'Capital', 'Population'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: TextShow(
                text: value,
                fontSize: 16,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: Colors.grey[100],
          iconSize: 22,
        ),
      ],
    );
  }
}
