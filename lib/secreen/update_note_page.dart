import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/data-helper.dart';
import 'package:notes/models/dialog-helper.dart';

import '../models/note-item.dart';
import 'my_note_detail_form.dart';

class UpdateNotePage extends StatefulWidget {
  final int noteId;

  const UpdateNotePage({this.noteId});

  @override
  UpdateNotePageState createState() {
    return UpdateNotePageState(noteId: noteId);
  }
}

class UpdateNotePageState extends State<UpdateNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleInputController = TextEditingController();
  final _contentInputController = TextEditingController();

  NoteItem _note;

  final int noteId;

  Color _currentColor = Colors.white;
  void _onChangeColor(Color color) => setState(() => _currentColor = color);
  UpdateNotePageState({this.noteId});

  @override
  void initState() {
    DataHelper.getSingle(noteId).then((value) => {
          setState(() {
            _note = value;
            _currentColor = _note.color;
          })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_formKey.currentState.validate()) {
          _note.title = _titleInputController.text;
          _note.content = _contentInputController.text;
          _note.colorValue = _currentColor.value;

          await DataHelper.update(_note);

          Navigator.pop(context, _note);
        }

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: _currentColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 85, 0, 255),
          title: Text('Edit Note'.tr()),
          actions: [
            IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () async {
                DialogHelper.showColorDialog(
                    context: context,
                    pickerColor: _currentColor,
                    onColorChanged: _onChangeColor);
              },
            ),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  DialogHelper.showConfirm(
                    context: context,
                    title: 'Delete'.tr(),
                    message: 'Are you sure you want to delete this note?'.tr(),
                    onOKPressed: () async {
                      _note.deleted = 1;
                      await DataHelper.update(_note);
                      Navigator.pop(context);
                      Navigator.pop(context, _note);
                    },
                  );
                }),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(child: _buildForm()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleInputController.dispose();
    super.dispose();
  }

  Widget _buildForm() {
    if (_note != null) {
      _titleInputController.text = _note.title;
      _contentInputController.text = _note.content;
    }

    return MyNoteDetailForm(
        key: _formKey,
        titleController: _titleInputController,
        contentController: _contentInputController);
  }
}
