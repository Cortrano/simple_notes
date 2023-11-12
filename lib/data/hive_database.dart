import 'package:hive/hive.dart';

import '../models/note.dart';

class HiveDatabase {
  final _myBox = Hive.box('notes_database');

  List<Note> loadNotes() {
    if (_myBox.get("ALL_NOTES") != null) {
      return _myBox.get("ALL_NOTES")!.cast<Note>();
    } else {
      return [Note.init(text: "Default Note")];
    }
  }

  void saveNotes(List<Note> allNotes) {
    _myBox.put("ALL_NOTES", allNotes);
  }
}