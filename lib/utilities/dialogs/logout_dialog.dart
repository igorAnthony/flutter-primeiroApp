import 'package:flutter/material.dart';
import 'package:flutter_primeiro_app/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Sign Out",
    content: "Are you sure you want to log out?",
    optionsBuilder: ()=> {
      'Log out':true,
      'Cancel':false,
    },
  ).then((value) => value ?? false);
}
