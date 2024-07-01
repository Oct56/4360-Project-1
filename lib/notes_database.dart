import 'package:mood_journal/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase{
  static Future<Database> _database() async{
    final database = openDatabase(
      join(await getDatabasesPath(), 'notes_database.db'),
      onCreate: (db, version){
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createdAT TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }

  static insert({required Note note}) async{
    final db = await _database();
    await db.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

  }
  static Future<List<Note>> getNotes() async{
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, 
      (i){
        return Note(
          id: maps[i]['id'] as int,
          title: maps[i]['title'] as String,
          description: maps[i]['description'] as String,
          createdAt: DateTime.parse(maps[i]['createdAt']) as DateTime,
        );
      }
    );
  }
   Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await _database();
    return await db!.query('notes');
  }

  static update({required Note note}) async{
    final db = await _database();
    await db.update('notes', note.toMap(), where: 'id=?', whereArgs: [note.id]);
  }

  static delete({required Note note}) async{
    final db = await _database();
    await db.delete('notes',
    where: 'id = ?',
    whereArgs: [note.id]);
  }
}