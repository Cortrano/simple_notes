import 'package:flutter/foundation.dart';
import 'package:simple_notes/data/hive_database.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
  final db = HiveDatabase();

  void init() {
    allNotes = db.loadNotes();
  }

  List<Note> allNotes = [];

  List<Note> getAllNotes() {
    return allNotes;
  }

  void addNewNote(Note note) {
    allNotes.add(note);
    db.saveNotes(allNotes);
    notifyListeners();
  }

  void updateNote(Note noteToUpdate, String text) {
    allNotes.firstWhere((element) => element == noteToUpdate).text = text;
    db.saveNotes(allNotes);
    notifyListeners();
  }

  void deleteNote(Note note) {
    allNotes.remove(note);
    db.saveNotes(allNotes);
    notifyListeners();
  }
}
