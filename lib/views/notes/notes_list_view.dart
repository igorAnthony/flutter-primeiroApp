import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_primeiro_app/services/cloud/cloud_note.dart';
import 'package:flutter_primeiro_app/services/crud/notes_service.dart';
import 'package:flutter_primeiro_app/utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(CloudNote note);


class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback onTap;
  
  const NotesListView({
    Key? key,
    required this.notes,
    required this.onDeleteNote, required this.onTap, 
  }) : super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 7.0),
          child: Card(
            color: Color(Random().nextInt(0xffffffff)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: ListTile(
              onTap:() {
                onTap(note);
              },
              title: Text(
                note.text,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              //contentPadding: const EdgeInsets.fromLTRB(20, 7, 10, 0),
              trailing: IconButton(
                onPressed: () async {
                  final shouldDelete = await showDeleteDialog(context);
                  if(shouldDelete){
                    onDeleteNote(note);
                  }
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          ),
        );
      },
    );
  }
}

