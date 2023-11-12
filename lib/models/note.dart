import 'dart:math';

import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  int id;

  @HiveField(1)
  String text;

  Note({
    required this.id,
    required this.text,
  });

  Note.init({
    required this.text,
  }) : id = Random().nextInt(100000);
}
