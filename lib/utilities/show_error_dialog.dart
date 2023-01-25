import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String textError) async {
  showDialog(
    context: context, 
    builder:(context) {
      return AlertDialog(
        title:const Text("An error occurred"),
        content: Text(textError),
        actions: [
          TextButton(onPressed:() {
            Navigator.of(context).pop();
          }, 
          child: const Text("OK"))
        ],
      );
    },
  );
}