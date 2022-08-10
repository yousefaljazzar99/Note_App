import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/data-helper.dart';
import 'package:notes/models/dialog-helper.dart';
import 'package:notes/secreen/my_note_detail_form.dart';

import '../models/note-item.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key key}) : super(key: key);

  @override
  AddNotePageState createState() {
    return AddNotePageState();
  }
}

class AddNotePageState extends State<AddNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleInputController = TextEditingController();
  final _contentInputController = TextEditingController();

  Color _currentColor = Colors.white;

  void _onChangeColor(Color color) => setState(() => _currentColor = color);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_titleInputController.text.isEmpty &&
            _contentInputController.text.isEmpty) {
          Navigator.pop(context);
          return Future.value(false);
        }

        if (_formKey.currentState.validate()) {
          Navigator.pop(context);
        }

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: _currentColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 85, 0, 255),
          title: Text('New Note'.tr()),
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
              icon: Icon(Icons.save),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  var note = NoteItem(
                      title: _titleInputController.text,
                      content: _contentInputController.text,
                      colorValue: _currentColor == null
                          ? Theme.of(context).canvasColor.value
                          : _currentColor.value);

                  var id = await DataHelper.addNote(note);
                  note.id = id;

                  Navigator.pop(context, note);
                }
              },
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: MyNoteDetailForm(
            key: _formKey,
            titleController: _titleInputController,
            contentController: _contentInputController,
          )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleInputController.dispose();
    super.dispose();
  }
}
