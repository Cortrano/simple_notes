class Note {
  final int id;
  final String text;

  Note({
    required this.id,
    required this.text,
  });

  Note copyWith({
    String? text,
    int? id,
  }) {
    return Note(
      id : id ?? this.id,
      text : text ?? this.text,
    );
  }
}
