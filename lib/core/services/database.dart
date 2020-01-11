import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:base/note/data/models.dart';
import 'package:path_provider/path_provider.dart';

class NotesDatabaseService {
  static final _databaseName = "memo.db";
  static final _databaseVersion = 1;

  static final table = 'memo';

  static final columnId = '_id';
  static final columnTitle = 'title';
  static final columnContent = 'content';
  static final columnIsImportant = 'isImportant';
  static final columnDate = 'date';

  String path;

  NotesDatabaseService._privateConstructor();
  static final NotesDatabaseService db =
      NotesDatabaseService._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    // if _database is null we instantiate it
    _database = await init();
    return _database;
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table ( 
      $columnId INTEGER PRIMARY KEY,
      $columnTitle TEXT,
      $columnContent TEXT,
      $columnIsImportant INTEGER,
      $columnDate TEXT
      )
      ''');
  }

  Future<List<NotesModel>> getNotesFromDB() async {
    final db = await database;
    List<NotesModel> notesList = [];
    List<Map> maps = await db.query(table);
    if (maps.length > 0) {
      maps.forEach((map) {
        notesList.add(NotesModel.fromMap(map));
      });
    }
    return notesList;
  }

  updateNoteInDB(NotesModel updatedNote) async {
    final db = await database;
    await db.update(table, updatedNote.toMap(),
        where: '$columnId = ?', whereArgs: [updatedNote.id]);
  }

  deleteNoteInDB(NotesModel noteToDelete) async {
    final db = await database;
    await db.delete(table, where: '$columnId = ?', whereArgs: [noteToDelete.id]);
    print('Note deleted');
  }

  Future<NotesModel> addNoteInDB(NotesModel newNote) async {
    final db = await database;
    if (newNote.title.trim().isEmpty) newNote.title = 'Untitled Note';
    int id = await db.transaction((transaction) => transaction.rawInsert(
        'INSERT into $table ($columnTitle, $columnContent, $columnIsImportant, $columnDate ) VALUES ("${newNote.title}", "${newNote.content}", "${newNote.isImportant == true ? 1 : 0}", "${newNote.date.toIso8601String()}");'));
    newNote.id = id;
    return newNote;
  }
}
