import 'package:blog/data/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

const String DB_NAME = 'todo.db';
const String TABLE_NAME = 'Task';
const String COLUMN_ID = 'id';
const String COLUMN_TITLE = 'title';
const String COLUMN_DESCRIPTION = 'description';

class TodoProvider {
  Database? db;
  Future open(String path) async {
    db = await openDatabase(join(await getDatabasesPath(), path), version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table $TABLE_NAME ( 
        $COLUMN_ID integer primary key autoincrement, 
        $COLUMN_TITLE varchar(255) not null,
        $COLUMN_DESCRIPTION varchar(255) not null)
      ''');
    });
  }

  Future<int> insert(Task task) async {
    await open(DB_NAME);
    int i = await db!.insert(TABLE_NAME, task.toBD());
    await close();
    return i;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    await open(DB_NAME);
    List<Map<String, dynamic>> maps = await db!
        .query(TABLE_NAME, columns: [COLUMN_TITLE, COLUMN_DESCRIPTION]);
    await close();

    if (maps.isNotEmpty) {
      maps.forEach((contactMap) {
        print(contactMap);
      });
      return maps;
    }
    return [];
  }

  Future close() async => db!.close();
}
