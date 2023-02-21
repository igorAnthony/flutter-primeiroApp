import 'package:flutter/material.dart';
import 'package:flutter_primeiro_app/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Delete",
    content: "Are you sure you want delete this item?",
    optionsBuilder: ()=> {
      'Yes':true,
      'Cancel':false,
    },
  ).then((value) => value ?? false);
}
