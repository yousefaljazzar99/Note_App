import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/data-helper.dart';
import 'package:notes/models/dialog-helper.dart';
import 'package:notes/secreen/my_note_detail_form.dart';

import '../models/note-item.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  NoteDetailPage({this.noteId});

  @override
  NoteDetailPageState createState() {
    return NoteDetailPageState(noteId: this.noteId);
  }
}

class NoteDetailPageState extends State<NoteDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleInputController = TextEditingController();
  final _contentInputController = TextEditingController();

  NoteItem _note;

  final int noteId;

  NoteDetailPageState({this.noteId});

  @override
  void initState() {
    DataHelper.getSingle(noteId).then((value) => {
          setState(() {
            _note = value;
          })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _note?.color,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                DialogHelper.showConfirm(
                  context: context,
                  title: 'Delete'.tr(),
                  message:
                      'Are you sure you want to permanently delete this note from the trash?'
                          .tr(),
                  onOKPressed: () async {
                    await DataHelper.delete(_note.id);
                    Navigator.pop(context);
                  },
                );
              }),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(child: _buildForm()),
      ),
    );
  }

  Widget _buildForm() {
    if (_note != null) {
      _titleInputController.text = _note.title;
      _contentInputController.text = _note.content;
    }
    return MyNoteDetailForm(
        key: _formKey,
        titleController: _titleInputController,
        contentController: _contentInputController,
        readOnly: true);
  }

  Future<void> _restoreNote(BuildContext context) async {
    _note.deleted = null;
    await DataHelper.update(_note);
    Navigator.pop(context, _note);
  }
}
