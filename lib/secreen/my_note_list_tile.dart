import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/dialog-helper.dart';
import 'package:notes/models/my-utils.dart';

import '../../models/note-item.dart';

class MyNoteListTile extends StatelessWidget {
  final NoteItem note;
  final GestureTapCallback onTap;

  MyNoteListTile({Key key, this.note, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          // leading: IconButton(
          //     icon: Icon(Icons.delete),
          //     onPressed: () {
          //       DialogHelper.showConfirm(
          //         context: context,
          //         title: 'Delete'.tr(),
          //         message: 'Are you sure you want to delete this note?'.tr(),
          //         onOKPressed: () async {
          //            _note.deleted = 1;
          //           //   await DataHelper.update(_note);
          //           Navigator.pop(context);
          //           // Navigator.pop(context, _note);
          //         },
          //       );
          //     }),
          tileColor: new Color(note.colorValue == null ? 0 : note.colorValue),
          key: ValueKey(note.id),
          title: Text(note.title),
          subtitle: Text(note.content),
          trailing: Text(
            MyUtils.formatDate(note.modifiedDate, 'dd MMM yyyy'),
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          onTap: onTap),
    );
  }
}
