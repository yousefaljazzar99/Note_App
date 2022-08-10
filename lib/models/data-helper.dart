import 'package:notes/models/note-item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DatabaseName = "simple_note_app_demo16.db";
const TableName = "notes";

class DataHelper {
  static Future<int> addNote(NoteItem note) async {
    final Database db = await _openDb();
    note.modifiedDate = new DateTime.now().millisecondsSinceEpoch;
    return await db.insert(
      TableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<NoteItem> getSingle(int id) async {
    final Database db = await _openDb();

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM $TableName WHERE id = $id');

    Map<String, dynamic> data = maps.length > 0 ? maps[0] : null;
    NoteItem note = NoteItem.fromMap(data);
    return Future.value(note);
  }

  static Future<List<NoteItem>> search(String query) async {
    final Database db = await _openDb();

    final List<Map<String, dynamic>> maps = await db.query(TableName,
        where: "(deleted is null or deleted = 0) AND title LIKE ?",
        whereArgs: ['%$query%']);

    return List.generate(maps.length, (i) {
      return NoteItem.fromMapTruncatedContent(maps[i]);
    });
  }

  static Future<List<NoteItem>> getAllWithTruncatedContent() async {
    final Database db = await _openDb();

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM $TableName WHERE deleted is null or deleted = 0 ORDER BY modifiedDate desc');

    return List.generate(maps.length, (i) {
      return NoteItem.fromMapTruncatedContent(maps[i]);
    });
  }

  static Future<List<NoteItem>> getAllDeletedNotes() async {
    final Database db = await _openDb();

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM $TableName WHERE deleted = 1  ORDER BY modifiedDate desc');

    return List.generate(maps.length, (i) {
      return NoteItem.fromMapTruncatedContent(maps[i]);
    });
  }

  static Future<void> emptyTrash() async {
    final Database db = await _openDb();

    await db.delete(TableName, where: "deleted = 1");
  }

  static Future<void> update(NoteItem note) async {
    final db = await _openDb();

    await db.update(
      TableName,
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  static Future<void> delete(int id) async {
    final db = await _openDb();

    await db.delete(
      TableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<Database> _openDb() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), DatabaseName),
      onCreate: (db, version) async {
        db.execute(
          "CREATE TABLE $TableName(id INTEGER PRIMARY KEY, title TEXT NOT NULL, content TEXT, deleted INTEGER, modifiedDate INTEGER, colorValue INTEGER NOT NULL)",
        );
      },
      version: 1,
    );

    return database;
  }
}
