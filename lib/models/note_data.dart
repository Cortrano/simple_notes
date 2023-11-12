import 'note.dart';

class NoteData {
  // overall list of notes
  List<Note> allNotes = [
    Note(id: 0, text: "First note"),
    Note(id: 0, text: "First note"),
  ];

  // get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  // add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
  }

  // update note
  void updateNote(Note noteToUpdate, String text) {
    for (final note in allNotes) {
      if (note.id == noteToUpdate.id) {
        note.copyWith(text: noteToUpdate.text);
      }
    }
  }

  // delete note
  void deleteNote(Note note) {
    allNotes.remove(note);
  }
}
