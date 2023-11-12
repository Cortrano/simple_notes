import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes/models/note_data.dart';

import '../models/note.dart';
import 'editing_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<NoteData>(context, listen: false).init();
    super.initState();
  }

  void createNewNote() {
    final Note newNote = Note.init(text: '');

    goToNotePage(newNote, true);
  }

  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingNotePage(
          note: note,
          isNewNote: isNewNote,
        ),
      ),
    );
  }

  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          elevation: 0,
          backgroundColor: Colors.grey[300],
          child: const Icon(
            Icons.add,
            color: Colors.grey,
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 75.0),
                child: Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              value.getAllNotes().isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Center(
                        child: Text(
                          "Nothing here",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    )
                  : CupertinoListSection.insetGrouped(
                      children: List.generate(
                        value.allNotes.length,
                        (index) => CupertinoListTile(
                          title: Text(value.getAllNotes()[index].text),
                          onTap: () =>
                              goToNotePage(value.getAllNotes()[index], false),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                deleteNote(value.getAllNotes()[index]),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
