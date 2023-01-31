// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_primeiro_app/enums/menu_action.dart';
import 'package:flutter_primeiro_app/services/auth/auth_service.dart';
import 'package:flutter_primeiro_app/services/crud/notes_service.dart';

import '../constants/routes.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  String get userEmail => AuthService.firebase().currentUser!.email!;
  late final NotesService _notesService;
  @override
  void initState() {
    _notesService = NotesService();
    super.initState();
  }
  @override
  void dispose() {
    _notesService.close(); 
    super.dispose(); 
  }
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
      body: FutureBuilder(
        future: _notesService.getOrCreateUser(email: userEmail),
        builder:(context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
              return StreamBuilder(
                stream: _notesService.allNotes,
                builder:(context, snapshot) {
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                      return const Text("Waiting for all notes...");
                    default:
                      return const CircularProgressIndicator();
                  }
                }
              );
            default:
              return const CircularProgressIndicator();
          }
        }, 
      )
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