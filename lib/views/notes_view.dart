import 'package:flutter/material.dart';
import 'package:flutter_primeiro_app/enums/menu_action.dart';
import 'package:flutter_primeiro_app/services/auth/auth_service.dart';

import '../constants/routes.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your notes"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
               switch(value){
                 case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if(shouldLogOut){
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute, 
                      (_) => false,
                    );
                  }
                  break;
               }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                    value: MenuAction.logout, child: Text("Logout"))
              ];
            },
          )
        ],
      ),
    );
  }
}
Future<bool> showLogOutDialog(BuildContext context){
  return showDialog(
    context: context, 
    builder:(context) {
      return AlertDialog(
        title:const Text("Sign out"),
        content: const Text("Are you sure you want sign out?"),
        actions: [
          TextButton(onPressed:() {
            Navigator.of(context).pop(false);
          }, 
          child: const Text("Cancel")),
          TextButton(onPressed:() {
            Navigator.of(context).pop(true);
          }, 
          child: const Text("Log out"))
        ],
      );
    },
  ).then((value) => value ?? false);
}