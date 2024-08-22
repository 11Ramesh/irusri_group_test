import 'package:countries_app/widgets/textshow.dart';
import 'package:flutter/material.dart';
//this is message widget.
//this use for floting message popup
class Messages {
  final BuildContext context;

  Messages(this.context);

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: TextShow(
            fontSize: 18,
            text: message,
          ),
        ),
        backgroundColor:
            Colors.red[400], 
        duration: const Duration(seconds: 5), 
      ),
    );
  }
}
