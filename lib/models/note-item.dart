import 'dart:ui';

import 'package:notes/models/my-utils.dart';

class NoteItem {
  int id;
  String title;
  String content;
  int deleted;
  int modifiedDate;
  int colorValue;

  NoteItem(
      {this.id,
      this.title,
      this.content,
      this.deleted,
      this.modifiedDate,
      this.colorValue});

  Color get color {
    return new Color(colorValue);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'deleted': deleted,
      'modifiedDate': modifiedDate,
      'colorValue': colorValue
    };
  }

  factory NoteItem.fromMap(Map<String, dynamic> data) => new NoteItem(
      id: data['id'],
      title: data['title'],
      content: data['content'],
      deleted: data['deleted'],
      modifiedDate: data['modifiedDate'],
      colorValue: data['colorValue']);

  factory NoteItem.fromMapTruncatedContent(Map<String, dynamic> data) =>
      new NoteItem(
          id: data['id'],
          title: data['title'],
          content: MyUtils.truncateWithEllipsis(data['content']),
          deleted: data['deleted'],
          modifiedDate: data['modifiedDate'],
          colorValue: data['colorValue']);

  @override
  String toString() {
    return 'Note($id, $title, $deleted, $colorValue)';
  }
}
