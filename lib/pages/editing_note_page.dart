import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes/models/note_data.dart';

import '../models/note.dart';

class EditingNotePage extends StatefulWidget {
  final Note note;
  final bool isNewNote;

  const EditingNotePage({
    super.key,
    required this.note,
    required this.isNewNote,
  });

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    loadExistingNote();
    super.initState();
  }

  void loadExistingNote() {
    final Document doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  void addNewNote() {
    final String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false)
        .addNewNote(Note.init(text: text));
  }

  void updateNote() {
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return QuillProvider(
      configurations: QuillConfigurations(
        controller: _controller,
      ),
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              if (widget.isNewNote && !_controller.document.isEmpty()) {
                addNewNote();
              } else {
                updateNote();
              }
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            const QuillToolbar(
              configurations: QuillToolbarConfigurations(
                showDirection: false,
                showAlignmentButtons: false,
                showBackgroundColorButton: false,
                showBoldButton: false,
                showCenterAlignment: false,
                showClearFormat: false,
                showCodeBlock: false,
                showColorButton: false,
                showDividers: false,
                showFontFamily: false,
                showFontSize: false,
                showHeaderStyle: false,
                showIndent: false,
                showInlineCode: false,
                showItalicButton: false,
                showJustifyAlignment: false,
                showLeftAlignment: false,
                showLink: false,
                showListBullets: false,
                showListCheck: false,
                showListNumbers: false,
                showQuote: false,
                showRightAlignment: false,
                showSearchButton: false,
                showSmallButton: false,
                showStrikeThrough: false,
                showSubscript: false,
                showSuperscript: false,
                showUnderLineButton: false,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: QuillEditor.basic(
                  configurations: const QuillEditorConfigurations(
                    readOnly: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
